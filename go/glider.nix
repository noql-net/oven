{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "glider";
  version = "0.16.4";

  src = fetchFromGitHub {
    owner = "nadoo";
    repo = "glider";
    rev = "v${version}";
    hash = "sha256-LrIHdI1/55llENjDgFJxh2KKsJf/tLT3P9L9jhLhfS0=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-v/HJUah+QC34hcf9y5yRSFO8OTkqD2wzdOH/wIXrKoA=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/nadoo/glider";
    license = lib.licenses.gpl3Plus;
  };
}
