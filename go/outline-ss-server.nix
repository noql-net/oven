{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "outline-ss-server";
  version = "1.7.3";

  src = fetchFromGitHub {
    owner = "Jigsaw-Code";
    repo = "outline-ss-server";
    rev = "v${version}";
    hash = "sha256-lY1CB5szAHgm4/RO1xHG2rCisXq379BfHrKG/2UQUGo=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-qcKOF+19R5QQkM10AcGeetPRA3gJAe5Rn6CR+TU5zZA=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/..." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Jigsaw-Code/outline-ss-server";
    license = lib.licenses.asl20;
  };
}
