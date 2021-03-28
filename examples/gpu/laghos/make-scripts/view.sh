#!/bin/bash
if [ -e ${DB}.d ]
then
  hpcviewer ${DB}.d 
else
  echo
  echo "****** hpctoolkit performance database '$DB.d' does not exist *****"
  echo
fi
