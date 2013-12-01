#!/bin/bash

VMSTAT="vm_stat"

if [[ `uname -s` != "Darwin" ]] ; then
  echo "Only for Darwin systems"
  exit 1
fi

function clearMemory() {
  pagesFree=`$VMSTAT | grep 'Pages free:' | tr -s ' ' | cut -d ' ' -f3 | cut -d '.' -f1`
  freeRAM_in_mbytes=$(( $pagesFree * 4096 / 1048576 ))

  [[ -z $1 ]] && limit=128 || limit=$1
  [[ $freeRAM_in_mbytes < $limit ]] && purge
}

clearMemory

