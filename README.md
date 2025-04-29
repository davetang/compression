# Test different compression algorithms

Download some data from my server.

```console
./bin/download.sh
```

## gz, xz, and bz2

Compression time and size.

```console
./bin/compress.sh
```
```
Creating test.fq: 4000000 lines
Timing compression for test.fq
Method: tar.gz
  Run 1: 25.079455715 seconds, size: 82MiB
  Run 2: 23.972182620 seconds, size: 82MiB
  Run 3: 23.963727669 seconds, size: 82MiB
Method: tar.xz
  Run 1: 163.365216818 seconds, size: 67MiB
  Run 2: 162.730457104 seconds, size: 67MiB
  Run 3: 163.296625634 seconds, size: 67MiB
Method: tar.bz2
  Run 1: 15.765786194 seconds, size: 66MiB
  Run 2: 15.433430940 seconds, size: 66MiB
  Run 3: 15.759382235 seconds, size: 66MiB
Done
```

## Full FASTQ

Extract.

```console
unpigz -c data/ERR031940_1.filt.fastq.gz > data/ERR031940_1.filt.fastq
```

Compression time and size on the full FASTQ file.

```console
./bin/compress.sh ERR031940_1.filt.fastq > ERR031940_1.filt.txt
```
```
Timing compression for ERR031940_1.filt.fastq
Method: tar.gz
Method: tar.xz
Method: tar.bz2
Done
```

Results.

```console
cat ERR031940_1.filt.txt
```
```
  Run 1: 1324.644394870 seconds, size: 4.4GiB
  Run 2: 1326.044701334 seconds, size: 4.4GiB
  Run 3: 1326.556338882 seconds, size: 4.4GiB
  Run 1: 8927.845167730 seconds, size: 3.6GiB
  Run 2: 8865.651998759 seconds, size: 3.6GiB
  Run 3: 8836.845128935 seconds, size: 3.6GiB
  Run 1: 856.985312803 seconds, size: 3.6GiB
  Run 2: 855.498427229 seconds, size: 3.6GiB
  Run 3: 878.457609050 seconds, size: 3.6GiB
```

Extraction time on different compressions.

```console
./bin/extract.sh ERR031940_1.filt.fastq
```
```
Timing extraction
Method: tar.gz
  Run 1: 78.395756227 seconds
  Run 2: 78.829205738 seconds
  Run 3: 78.898753542 seconds
Method: tar.xz
  Run 1: 216.682740982 seconds
  Run 2: 219.028032811 seconds
  Run 3: 216.031525513 seconds
Method: tar.bz2
  Run 1: 396.967331756 seconds
  Run 2: 396.499087252 seconds
  Run 3: 397.138759535 seconds
Done
```

[Zstandard](https://github.com/facebook/zstd).

```console
./bin/zstd.sh
```
```
Original size: 13G      /data/github/compression/data/ERR031940_1.filt.fastq
md5sum: a9f832ad1569040426e356d7b6fb9d3e  /data/github/compression/data/ERR031940_1.filt.fastq
Compressing...
Compressed size: 4.5G   /data/github/compression/data/ERR031940_1.filt.fastq.zst
Compression time: 81.590140039 seconds
Decompressing...
Decompression time: 46.447133097 seconds
md5sum: a9f832ad1569040426e356d7b6fb9d3e  /data/github/compression/data/ERR031940_1.filt.fastq.decompressed
Done
```
