{ lib, fetchFromGitHub, buildRustPackage, rustTarget, buildCC, targetCC }:

buildRustPackage rec {
  pname = "shadow-tls";
  version = "0.2.19";

  src = fetchFromGitHub {
    owner = "ihciah";
    repo = "shadow-tls";
    rev = "v${version}";
    hash = "sha256-pFWtY+aS+/1wEu5piz54GUPROH9b4YuVT6JhKjmnC1k=";
  };

  CARGO_BUILD_TARGET = rustTarget;
  CARGO_BUILD_RUSTFLAGS = "-C target-feature=+crt-static";
  rustTargetUpper = lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] rustTarget);
  "CARGO_TARGET_${rustTargetUpper}_LINKER" = targetCC;
  TARGET_CC = targetCC;
  HOST_CC = buildCC;

  doCheck = false;

  meta = {
    homepage = "https://github.com/ihciah/shadow-tls";
    license = lib.licenses.mit;
  };
}
