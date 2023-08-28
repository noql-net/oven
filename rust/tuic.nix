{ lib, fetchFromGitHub, buildRustPackage, vendorCargoDeps, rustTarget, targetCC }:

buildRustPackage rec {
  pname = "tuic";
  version = "5.0.0";

  src = fetchFromGitHub {
    owner = "EAimTY";
    repo = "tuic";
    rev = "tuic-${version}";
    hash = "sha256-VoNr91vDqBlt9asT/dwCeYk13UNiDexNNiKwD5DSn8k=";
  };

  cargoVendorDir = vendorCargoDeps { cargoLock = ./tuic.lock; };

  CARGO_BUILD_TARGET = rustTarget;
  "CARGO_TARGET_${lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] rustTarget)}_LINKER" = targetCC;
  TARGET_CC = targetCC;

  doCheck = false;

  meta = {
    homepage = "https://github.com/EAimTY/tuic";
    license = lib.licenses.gpl3Plus;
  };
}
