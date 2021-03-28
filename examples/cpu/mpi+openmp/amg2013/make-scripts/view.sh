#!/bin/bash
OUT=hpctoolkit-amg2013

module load hpcviewer 

if [[ -z "`type -p hpcviewer`" ]] 
then
    echo "hpcviewer is not on your path. load the appropriate hpcviewer module"
    exit
fi

hpcviewer ${OUT}.d 
