# A simple Nix/Haskell project that doesn't build

To see the failure:

`nix-build`

It fails because `optics-th` depends on `template-haskell` and it can't find it.

It seems to be bringing in `optics-th-0.3.0.2` despite the `default.nix` trying to override it to pull in `optics-th` in the `0.4` series.

I tried to simplify to just trying to figure out why `optics` is depending on the wrong version of `optics-th`:

`nix-build optics.nix`

This also fails because `optics-th` cannot find the right version of `optics-core`.
