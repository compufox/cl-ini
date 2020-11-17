# cl-ini
### _ava fox_

parse an INI file into an alist

## Installing

```shell
$ mkdir ~/common-lisp
$ git clone https://github.com/compufox/cl-ini ~/common-lisp/cl-ini
```

then

```lisp
* (ql:quickload :cl-ini)
```

## API

`(parse-ini file)` => `nested alist`

reads FILE in and parses it

if no section is defined then all key-pairs are put into a :GLOBAL section

returns an alist with the same structure of the ini file

---

`(ini-value ini key &key (section :global))` => `value OR nil`

returns the value of KEY for SECTION in INI

returns NIL if key does not exist

## License

MIT

