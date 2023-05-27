# Raybox Reciprocal

This is a Verilog module to be used as part of my [Raybox](https://github.com/algofoogle/raybox) project.

It aims to provide a pretty good approximation of the reciprocal of a fixed-point number immediately
through combinational logic (i.e. single-step only).

In this respect, I think it is similar to the x86 [`RCPSS` instruction](https://www.felixcloutier.com/x86/rcpss).

Note that I didn't come up with this method. The code is mostly unchanged from
[reciprocal-sv](https://github.com/ameetgohil/reciprocal-sv) by
[Ameet Gohil](https://github.com/ameetgohil), which in turn I think is based on
[this "Reciprocal Approximation" work](https://observablehq.com/@drom/reciprocal-approximation) by
[@drom (Aliaksei Chapyzhenka)](https://github.com/drom).
