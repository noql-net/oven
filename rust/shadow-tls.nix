{ lib, fetchFromGitHub, buildRustPackage, rustTarget, targetCC }:

buildRustPackage rec {
  pname = "shadow-tls";
  version = "0.2.23";

  src = fetchFromGitHub {
    owner = "ihciah";
    repo = "shadow-tls";
    rev = "v${version}";
    hash = "sha256-XMoNCSSj76aGJzGatOudwWO21qimlgeRMGNUmzxzM6I=";
  };

  CARGO_BUILD_TARGET = rustTarget;
  "CARGO_TARGET_${lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] rustTarget)}_LINKER" = targetCC;
  TARGET_CC = targetCC;

  doCheck = false;

  meta = {
    homepage = "https://github.com/ihciah/shadow-tls";
    license = lib.licenses.mit;
  };
}
