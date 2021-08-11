# Example Pepper OS

Here are examples from the articles of the resource habr.com

## Tags - examples

Tag          | Link
------------ | -------------
1-example    | https://habr.com/ru/company/neobit/blog/173263/
2-example    | https://habr.com/ru/company/neobit/blog/174157/
3-example    | https://habr.com/ru/company/neobit/blog/176707/


## Build

System: Ubuntu 18.04 gcc version gcc-7.5.0

```
$ make all
$ sudo make image
```

## Launch

### Without debug

```
$ qemu-system-i386 -hda hdd.img
```

### With a debug

```
$ sudo qemu-system-i386 -s -S -hda hdd.img &
$ cgdb kernel.bin.dbg

(gdb) target remote localhost:1234
(gdb) break main
(gdb) c
(gdb) n
...

```




