module load craype-accel-nvidia60
#module load craype-accel-nvidia70
export CMAKE_CXX_COMPILER=CC
export MINIQMC_COMPILER_FLAGS="-DQMC_MPI=1 -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment"
export LDFLAGS="${CRAY_PMI_POST_LINK_OPTS} -Wl,-rpath=/opt/cray/pe/pmi/5.0.14/lib64 -lpmi"
export MINIQMC_LAUNCHER=srun

echo the configuration on cori currently doesn't link because of undefined references to PMI2 from the Intel compiler
