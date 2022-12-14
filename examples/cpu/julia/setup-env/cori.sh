  # unload darshan
  module unload darshan

  # load hpctoolkit modules
  module use /global/common/software/m3977/hpctoolkit/2021-11/modules
  module load hpctoolkit/2021.11-cpu
  module load julia

  export HPCTOOLKIT_JULIA_RUN=sh
  export HPCTOOLKIT_JULIA_ANALYZE=sh
  export HPCTOOLKIT_JULIA_VIEW=sh

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=julia
