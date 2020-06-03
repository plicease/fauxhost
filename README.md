# libfauxhostname

## SYNOPSIS

```
% make
clang -c -O2 -fPIC -o fauxhostname.o fauxhostname.c
clang -shared -o libfauxhostname.so fauxhostname.o
% export LD_PRELOAD=`pwd`/libfauxhostname.so
% hostname
faux
% export FAUXHOSTNAME=foo
% hostname
foo
```

## DESCRIPTION

This is a simple `LD_PRELOAD` library which provides its own
`gethostname` function which can be used for testing.  By
default it returns `faux` instead of the system's actual hostname.
You can override this default with the `FAUXHOSTNAME` environment
variable.

## TESTS

You can run the tests by using `make test`.  It requires Perl, cpanm,
[FFI::Platypus](https://metacpan.org/pod/FFI::Platypus) and
[Test2::V0](https://metacpan.org/pod/Test2::V0).  If the Perl modules
aren't installed they will be installed for you.

## CAVEATS

Probably only safe to use in testing.

## LICENSE

This software is copyright (c) 2020 Graham Ollis

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

Terms of the Perl programming language system itself

a) the GNU General Public License as published by the Free
   Software Foundation; either version 1, or (at your option) any
   later version, or
b) the "Artistic License"

(See the `LICENSE` file for full details).
