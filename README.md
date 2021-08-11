# Example Pepper OS

Here are examples from the articles of the resource habr.com

## Branches - examples

Branch       | Link
------------ | -------------
main         | [1-example](https://habr.com/ru/company/neobit/blog/173263/)
2-example    | [2-example](https://habr.com/ru/company/neobit/blog/174157/)


## Build

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




