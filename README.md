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
