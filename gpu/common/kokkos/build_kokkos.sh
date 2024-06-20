#!/bin/bash

usage() {
  echo
  echo "Kokkos build script"
  echo "Usage: $(basename $0) [-h] <kokkos_version> <kokkos_install_dir>"
  echo
}

case "$1" in
  "" | "-h" | "--help" ) usage; exit 0;;  
esac
KOKKOS_VER="$1"

if [ -z "$2" ]; then usage; exit 0; fi
KOKKOS_INSTALL_DIR="$(realpath -m $2)"

kokkos_download() {

  if [[ "${KOKKOS_VER::1}" =~ [0-9] ]]; then
    # Download Kokkos release tarball
    if [ ! -f "kokkos-${KOKKOS_VER}.tar.gz" ]; then
      echo "Downloading tarball for Kokkos release ${KOKKOS_VER}"  
      wget -O "kokkos-${KOKKOS_VER}.tar.gz" "https://github.com/kokkos/kokkos/archive/${KOKKOS_VER}.tar.gz" || return $?
    fi
    rm -rf "kokkos-${KOKKOS_VER}"
    tar xzf "kokkos-${KOKKOS_VER}.tar.gz" || return $?
  else
    # Clone Kokkos git repo
    rm -rf "kokkos-${KOKKOS_VER}"
    echo "Cloning Kokkos repository ${KOKKOS_VER} branch"
    git clone -b "${KOKKOS_VER}" https://github.com/kokkos/kokkos.git "kokkos-${KOKKOS_VER}" || return $?
  fi

}

declare -a KOKKOS_FLAGS
kokkos_set_arch() {

  # CPU arch
  if [ -z "${HPCTOOLKIT_KOKKOS_CPU_BACKEND}" ]; then
    HPCTOOLKIT_KOKKOS_CPU_BACKEND=SERIAL
  fi
  KOKKOS_FLAGS+=("-DKokkos_ENABLE_${HPCTOOLKIT_KOKKOS_CPU_BACKEND}=ON")
  if [ -n "${HPCTOOLKIT_KOKKOS_HOST_ARCH}" ]; then
    KOKKOS_FLAGS+=("-DKokkos_ARCH_${HPCTOOLKIT_KOKKOS_HOST_ARCH}=ON")
  fi

  # GPU arch
  if [ ! "${HPCTOOLKIT_KOKKOS_GPU_BACKEND}" = "NONE" ]; then
    KOKKOS_FLAGS+=("-DKokkos_ENABLE_${HPCTOOLKIT_KOKKOS_GPU_BACKEND}=ON")
    if [ -n "${HPCTOOLKIT_KOKKOS_GPU_ARCH}" ]; then
      KOKKOS_FLAGS+=("-DKokkos_ARCH_${HPCTOOLKIT_KOKKOS_GPU_ARCH}=ON")
    fi
  fi

}

if [ -z "${HPCTOOLKIT_KOKKOS_GPU_BACKEND}" ]; then
  HPCTOOLKIT_KOKKOS_GPU_BACKEND=NONE
fi

KOKKOS_WD="$(dirname $(realpath $0))"
pushd "${KOKKOS_WD}"

KOKKOS_SOURCE_DIR="kokkos-${KOKKOS_VER}"
KOKKOS_BUILD_DIR="kokkos-${KOKKOS_VER}/build-${HPCTOOLKIT_KOKKOS_GPU_BACKEND}"

# Check whether a successful build already exists
BUILD_KOKKOS=1
if [ -f kokkos.build.done ]; then
  found="$(grep -c ${KOKKOS_VER}-${HPCTOOLKIT_KOKKOS_GPU_BACKEND} kokkos.build.done)"
  if [ "x${found}" = "x1" ]; then
    BUILD_KOKKOS=0
  fi
fi
if [ "x${BUILD_KOKKOS}" = "x1" ]; then

  # Get source
  kokkos_download
  if [ ! $? = 0 ]; then
    echo "Failed to download Kokkos ${KOKKOS_VER}"
    exit 1
  fi

  # Set up build flags
  KOKKOS_FLAGS+=("-S${KOKKOS_SOURCE_DIR}")
  KOKKOS_FLAGS+=("-B${KOKKOS_BUILD_DIR}")
  KOKKOS_FLAGS+=("-DCMAKE_INSTALL_PREFIX=${KOKKOS_INSTALL_DIR}")
  KOKKOS_FLAGS+=("-DCMAKE_BUILD_TYPE=RelWithDebInfo")
  KOKKOS_FLAGS+=("-DKokkos_ENABLE_EXAMPLES=OFF")
  kokkos_set_arch
  if [ -n "${HPCTOOLKIT_KOKKOS_GPU_FLAGS}" ]; then
    KOKKOS_FLAGS+=("${HPCTOOLKIT_KOKKOS_GPU_FLAGS}")
  fi
  if [ -n "${HPCTOOLKIT_KOKKOS_EXTRA_FLAGS}" ]; then
    KOKKOS_FLAGS+=("${HPCTOOLKIT_KOKKOS_EXTRA_FLAGS}")
  fi

  # Configure
  rm -rf "${KOKKOS_BUILD_DIR}"
  cmake "${KOKKOS_FLAGS[@]}"
  if [ ! $? = 0 ]; then
    echo "Failed to configure Kokkos"
    exit 2
  fi

  # Build
  cmake --build "${KOKKOS_BUILD_DIR}" --parallel 8
  if [ $? = 0 ]; then
    echo "${KOKKOS_VER}-${HPCTOOLKIT_KOKKOS_GPU_BACKEND}" >> kokkos.build.done
  else
    echo "Failed to build Kokkos"
    exit 3
  fi

fi # BUILD_KOKKOS

# Install
rm -rf "${KOKKOS_INSTALL_DIR}"
cmake --install "${KOKKOS_BUILD_DIR}" --prefix "${KOKKOS_INSTALL_DIR}"

popd
