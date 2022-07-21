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
      optics = self.callHackageDirect {
        pkg = "optics";
        ver = "0.4.2";
        sha256 = "sha256-QsR0UCUR2EUvPuOHHMXV7MeVgsXfcNzbuYiJ6q6pMx0=";
      } {};
      optics-th = self.callHackageDirect {
        pkg = "optics-th";
        ver = "0.4.1";
        sha256 = "sha256-LswYTbNXkJja3vERy6ioTAYtfyUBTEspML5fr3YDWo4=";
      } {};
      optics-core = self.callHackageDirect {
        pkg = "optics-core";
        ver = "0.4.1";
        sha256 = "sha256-JnSrzSZW1dRkKBbTamCc705eRXZzfpmqru4jOTe2dX4=";
      } {};
      optics-extra = self.callHackageDirect {
        pkg = "optics-extra";
        ver = "0.4.2";
        sha256 = "sha256-fDjNpV09fZfpEfOLyPC6dXaolXhNY0N1A4bnDc5F8wo=";
      } {};
    });
});
  in
hPackages.callPackage ./cabal2nix.nix {}
