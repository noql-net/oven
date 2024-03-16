{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-knife";
  version = "2.8.16";

  src = fetchFromGitHub {
    owner = "lilendian0x00";
    repo = "xray-knife";
    rev = "v${version}";
    hash = "sha256-AzZte/uB4XigumgqIgF+1boaxFZ6rNO1xwgPl8Xizf0=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-VZrXTuJv8w24ct7kBpOEb3LHAVlqC+zC/TiAVJNr9/s=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/lilendian0x00/xray-knife";
    license = lib.licenses.mit;
  };
}
