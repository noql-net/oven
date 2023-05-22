{ lib, fetchFromGitHub, buildRustPackage, rustTarget, buildCC, targetCC }:

buildRustPackage rec {
  pname = "shadow-tls";
  version = "0.2.20";

  src = fetchFromGitHub {
    owner = "ihciah";
    repo = "shadow-tls";
    rev = "v${version}";
    hash = "sha256-mVYwIsWOxm3NPIGkc5Fft0cCVYHgBfJie70QkpZv2H0=";
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
