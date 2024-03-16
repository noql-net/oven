{ lib, fetchFromGitHub, buildRustPackage, rustTarget, targetCC }:

buildRustPackage rec {
  pname = "gping";
  version = "1.16.1";

  src = fetchFromGitHub {
    owner = "orf";
    repo = "gping";
    rev = "gping-v${version}";
    hash = "sha256-hCqjbJt0dHuvFsWEF/WgLEPY2xws71wFGdhzThYOOvA=";
  };

  CARGO_BUILD_TARGET = rustTarget;
  "CARGO_TARGET_${lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] rustTarget)}_LINKER" = targetCC;
  TARGET_CC = targetCC;

  doCheck = false;

  meta = {
    homepage = "https://github.com/orf/gping";
    license = lib.licenses.mit;
  };
}
