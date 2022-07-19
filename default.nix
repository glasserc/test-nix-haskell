let
  nixpkgs =
    import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "my-specific-nix";
  # Commit hash for nixos-unstable as of 2018-09-12
  url = "https://github.com/nixos/nixpkgs/archive/573603b7fdb9feb0eb8efc16ee18a015c667ab1b.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1z7mxyw5yk1gcsjs5wl8zm4klxg4xngljgrsnpl579l998205qym";
    }) {};
in
{ pkgs ? nixpkgs, compiler ? "ghc921" }:
let
  hPackages = pkgs.haskell.packages.${compiler}.override (old: {
    overrides = pkgs.lib.composeExtensions old.overrides (self: super: rec {
      optics-th = (pkgs.haskell.lib.overrideCabal super.optics-th_0_4 (old: {
        version = "0.4.1";
        sha256 = "05zxljfqmhr5if7l8gld5s864nql6kqjfizsf1z7r3ydknvmff6p";
      })); #.overrideScope (_: _: {});
      optics-core = (pkgs.haskell.lib.overrideCabal super.optics-core_0_4 (old: {
        version = "0.4.1";
        sha256 = "16ll8829g8v5g6gqdcfj77k6g4sqpmpxbda9jhm4h68pycay4r6a";
      }));
      optics = (pkgs.haskell.lib.overrideCabal super.optics_0_4 (old: {
        version = "0.4.2";
        # FIXME: I just copied this in for now
        sha256 = "16ll8829g8v5g6gqdcfj77k6g4sqpmpxbda9jhm4h68pycay4r6b";
      }));
    });
});
  in
hPackages.callPackage ./cabal2nix.nix {}
