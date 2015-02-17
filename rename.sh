#!/bin/sh
set -eu

error() {
  echo "[quit] command error."
  echo "example1: $0 access_log --noop"
  echo "example2: $0 access_log"
  exit 1
}

if [ $# -eq 0 ];then
  error
fi

BASENAME=$1

for i in ${BASENAME}.*.gz
do
  YMD=$(stat -c %y $i | cut -f 1 -d " ")
  if [ $# -eq 2 ];then
    if [ $2 = "--noop" ];then
      echo mv $i ${BASENAME}.${YMD}.gz
    else
      error
    fi
  else
    mv $i ${BASENAME}.${YMD}.gz
  fi
done
