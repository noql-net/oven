{ lib, fetchFromGitHub, buildRustPackage, vendorCargoDeps, file }:

buildRustPackage rec {
  pname = "tuic";
  version = "5.0.0";

  src = fetchFromGitHub {
    owner = "EAimTY";
    repo = "tuic";
    rev = "tuic-${version}";
    hash = "sha256-VoNr91vDqBlt9asT/dwCeYk13UNiDexNNiKwD5DSn8k=";
  };

  cargoExtraArgs = "";
  cargoVendorDir = vendorCargoDeps { cargoLock = ./tuic.lock; };

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/EAimTY/tuic";
    license = lib.licenses.gpl3Plus;
  };
}
