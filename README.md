# Test different compression algorithms

Download some data from my server.

```console
./bin/download.sh
```

## gz versus xz

Compression time and size.

```console
./bin/compress.sh
```
```
Creating test.fq
Timing compression for test.fq
Method: tar.gz
  Run 1: 2.395504678 seconds, size: 8.1MiB
  Run 2: 2.406918665 seconds, size: 8.1MiB
  Run 3: 2.440442703 seconds, size: 8.1MiB
Method: tar.xz
  Run 1: 15.346361435 seconds, size: 6.6MiB
  Run 2: 15.363561849 seconds, size: 6.6MiB
  Run 3: 15.453362495 seconds, size: 6.6MiB
Done
```
