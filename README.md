# bash-realpath

Bash utility behaves like [realpath(1)](http://man7.org/linux/man-pages/man1/realpath.1.html).

# Usage

```sh
. realpath.sh
realpath path/to/something
```

It outputs absolute path of the argument following symlinks recursively.

# Testing

You need [progrhyme/shove](https://github.com/progrhyme/shove) for testing.

Install shove, then run:

```sh
make
```

# License

The MIT License.

Copyright (c) 2020 IKEDA Kiyoshi.
