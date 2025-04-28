#!/usr/bin/env bash

set -euo pipefail

SCRIPTDIR=$(realpath $(dirname $0))
ROOTDIR=$(realpath ${SCRIPTDIR}/..)
DATADIR=${ROOTDIR}/data

if [[ $# > 0 ]]; then
   INPUT_FILE=$1
   if [[ ! -e ${DATADIR}/${INPUT_FILE} ]]; then
      >&2 echo ${DATADIR}/${INPUT_FILE} does not exist
      exit 1
   fi
else
   INPUT_FILE=test.fq
   BASENAME=$(basename "$INPUT_FILE")
   DIRNAME=$(dirname "$INPUT_FILE")
   LINES=4000000
   >&2 echo "Creating ${INPUT_FILE}: ${LINES} lines"
   zcat ${DATADIR}/ERR031940_1.filt.fastq.gz | head -n ${LINES} > ${DATADIR}/${INPUT_FILE} || [ $? -eq 141 ]
fi

>&2 echo "Timing compression for ${INPUT_FILE}"
for METHOD in gz xz bz2; do
   cd ${DATADIR}
   >&2 echo "Method: tar.${METHOD}"
   for i in {1..3}; do
      START=$(date +%s.%N)
      ARCHIVE=${INPUT_FILE}.tar.${i}.${METHOD}

      if [[ "${METHOD}" == "gz" ]]; then
         tar -czf "${ARCHIVE}" "${INPUT_FILE}"
      elif [[ "${METHOD}" == "xz" ]]; then
         tar -cJf "${ARCHIVE}" "${INPUT_FILE}"
      elif [[ "${METHOD}" == "bz2" ]]; then
         tar -cjf "${ARCHIVE}" "${INPUT_FILE}"
      else
         >&2 echo Unexpected method
         exit 1
      fi

      END=$(date +%s.%N)
      ELAPSED=$(echo "${END} - ${START}" | bc)
      FILE_SIZE=$(stat --printf="%s" "${ARCHIVE}" 2>/dev/null || stat -f "%z" "${ARCHIVE}")
      FILE_SIZE_HR=$(numfmt --to=iec-i --suffix=B "${FILE_SIZE}" 2>/dev/null || echo "${FILE_SIZE} bytes")
      printf "  Run %d: %s seconds, size: %s\n" "$i" "${ELAPSED}" "${FILE_SIZE_HR}"
   done
done

>&2 echo Done
exit 0
