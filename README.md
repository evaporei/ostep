# ostep

Code from OSTEP book.

## How to compile the examples

Change to any of the chapter directories, eg: `introduction`, choose an example and:

1. Use `cc/gcc` (cringe), classic format: `cc -o EXE-NAME SOURCE_FILES -Wall`.

```bash
$ cc -o cpu cpu.c common.c -Wall
$ ./cpu A
```

2. `zig cc` (lil' bit better, you get good defaults like `-Wall`).

```bash
$ zig cc -o cpu cpu.c common.c
$ ./cpu A
```

3. Use zig's `build-exe` (you don't need to specify the binary name 🙏).

```bash
$ zig build-exe cpu.c common.c --library c
$ ./cpu A
```

4. Be based and use `build.zig` script 😎.

```bash
$ zig build
$ ./zig-out/bin/cpu A
```

5. Transcend and create a script that builds **and** runs your C programs ⚖️..

```bash
$ zig build run-cpu -- A
```
