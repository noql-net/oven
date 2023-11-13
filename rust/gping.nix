{ lib, fetchFromGitHub, buildRustPackage, rustTarget, targetCC }:

buildRustPackage rec {
  pname = "gping";
  version = "1.15.1";

  src = fetchFromGitHub {
    owner = "orf";
    repo = "gping";
    rev = "gping-v${version}";
    hash = "sha256-22Nio6yfkL9HWNrI+kk5dGfojTtB/h0sizCWH9w9so8=";
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
