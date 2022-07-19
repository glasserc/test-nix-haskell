{ mkDerivation, base, lib, optics, optics-th }:
mkDerivation {
  pname = "nix-haskell";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base optics optics-th ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
