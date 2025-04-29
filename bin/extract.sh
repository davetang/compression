#!/usr/bin/env bash

set -euo pipefail

SCRIPTDIR=$(realpath $(dirname $0))
ROOTDIR=$(realpath ${SCRIPTDIR}/..)
DATADIR=${ROOTDIR}/data

if [[ $# == 1 ]]; then
   BASENAME=$1
else
   >&2 echo "Usage: $0 <basename>"
   exit 1
fi

>&2 echo "Timing extraction"
for METHOD in gz xz bz2; do
   cd ${DATADIR}
   >&2 echo "Method: tar.${METHOD}"
   for i in {1..3}; do
      START=$(date +%s.%N)
      ARCHIVE=${BASENAME}.tar.${i}.${METHOD}
      if [[ ! -e ${ARCHIVE} ]]; then
         >&2 echo ${ARCHIVE} does not exist
         exit 1
      fi

      if [[ "${METHOD}" == "gz" ]]; then
         tar -xzf "${ARCHIVE}"
      elif [[ "${METHOD}" == "xz" ]]; then
         tar -xJf "${ARCHIVE}"
      elif [[ "${METHOD}" == "bz2" ]]; then
         tar -xjf "${ARCHIVE}"
      else
         >&2 echo Unexpected method
         exit 1
      fi

      END=$(date +%s.%N)
      ELAPSED=$(echo "${END} - ${START}" | bc)
      printf "  Run %d: %s seconds\n" "$i" "${ELAPSED}"
   done
done

>&2 echo Done
exit 0
