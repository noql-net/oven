{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "brook";
  version = "20240214";

  src = fetchFromGitHub {
    owner = "txthinking";
    repo = "brook";
    rev = "v${version}";
    hash = "sha256-5+AqlmDa11PrB24XkelOFHK4sBi4j78WMLQrzDuP1/M=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-cTw9k4AqS4NOJ0vX0InR0xxOfCXIgA3FxgL6oXryOnA=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "cli/brook" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/txthinking/brook";
    license = lib.licenses.gpl3Plus;
  };
}
