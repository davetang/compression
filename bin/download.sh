#!/usr/bin/env bash

set -euo pipefail

SCRIPTDIR=$(realpath $(dirname $0))
ROOTDIR=$(realpath ${SCRIPTDIR}/..)

mkdir -p ${ROOTDIR}/data

URLS=(
https://davetang.org/file/single_exome/ERR031940_1.filt.fastq.gz
https://davetang.org/file/single_exome/ERR031940_2.filt.fastq.gz
)

for URL in ${URLS[@]}; do
   FILE=$(basename ${URL})
   OUTFILE=${ROOTDIR}/data/${FILE}
   if [[ ! -e ${OUTFILE} ]]; then
      wget -O ${OUTFILE} -c ${URL}
   fi
done

>&2 echo Done
exit 0
