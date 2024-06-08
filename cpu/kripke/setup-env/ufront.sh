# load modules needed to build and run kripke
module use /projects/modulefiles
module use /usr/local/modules
# module load cuda/11.8
# module load cmake

unset QA_TEST_VARIANT

export CMAKE_COMMON_OPTIONS="\
    -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
    -DCMAKE_CXX_STANDARD=17"

export KRIPKE_CONFIG=

# modules for hpctoolkit
export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/msi3"
$HPCTOOLKIT_MODULES_HPCTOOLKIT

# environment settings for this example
export HPCTOOLKIT_KRIPKE_ROOT="$(pwd)"
export HPCTOOLKIT_KRIPKE_MODULES_BUILD=""
export HPCTOOLKIT_KRIPKE_SUBMIT="sh"
export HPCTOOLKIT_KRIPKE_RUN="sh"
export HPCTOOLKIT_KRIPKE_RUN_PC="sh"
export HPCTOOLKIT_KRIPKE_BUILD="sh"
export HPCTOOLKIT_KRIPKE_OMP_NUM_THREADS=1
export HPCTOOLKIT_KRIPKE_LAUNCH="sh"

# mark configuration for this example
export HPCTOOLKIT_EXAMPLE=Kripke$QA_TEST_VARIANT
