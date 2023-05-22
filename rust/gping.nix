{ lib, fetchFromGitHub, buildRustPackage, rustTarget, buildCC, targetCC }:

buildRustPackage rec {
  pname = "gping";
  version = "1.11.0";

  src = fetchFromGitHub {
    owner = "orf";
    repo = "gping";
    rev = "gping-v${version}";
    hash = "sha256-5B9JMb+CTDBeV8zdq9WmbYihy8BfakUSU0XW5BGGoGI=";
  };

  CARGO_BUILD_TARGET = rustTarget;
  CARGO_BUILD_RUSTFLAGS = "-C target-feature=+crt-static";
  rustTargetUpper = lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] rustTarget);
  "CARGO_TARGET_${rustTargetUpper}_LINKER" = targetCC;
  TARGET_CC = targetCC;
  HOST_CC = buildCC;

  doCheck = false;

  meta = {
    homepage = "https://github.com/orf/gping";
    license = lib.licenses.mit;
  };
}
