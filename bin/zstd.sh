#!/usr/bin/env bash

set -euo pipefail

SCRIPTDIR=$(realpath $(dirname $0))
ROOTDIR=$(realpath ${SCRIPTDIR}/..)
DATADIR=${ROOTDIR}/data
INPUT_FILE=${DATADIR}/"ERR031940_1.filt.fastq"

>&2 echo "Original size: $(du -h ${INPUT_FILE})"
>&2 echo "md5sum: $(md5sum ${INPUT_FILE})"

>&2 echo "Compressing..."
START_COMPRESS=$(date +%s.%N)
zstd --force -q -o "${INPUT_FILE}.zst" "$INPUT_FILE"
END_COMPRESS=$(date +%s.%N)
COMPRESS_TIME=$(echo "${END_COMPRESS} - ${START_COMPRESS}" | bc)

>&2 echo "Compressed size: $(du -h ${INPUT_FILE}.zst)"
>&2 echo "Compression time: ${COMPRESS_TIME} seconds"

>&2 echo "Decompressing..."
START_DECOMPRESS=$(date +%s.%N)
zstd -q -d -o "${INPUT_FILE}.decompressed" "${INPUT_FILE}.zst"
END_DECOMPRESS=$(date +%s.%N)
DECOMPRESS_TIME=$(echo "${END_DECOMPRESS} - ${START_DECOMPRESS}" | bc)
>&2 echo "Decompression time: ${DECOMPRESS_TIME} seconds"
>&2 echo "md5sum: $(md5sum ${INPUT_FILE}.decompressed)"

rm "${INPUT_FILE}.decompressed"

>&2 echo Done
exit 0
