{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-knife";
  version = "1.6.12";

  src = fetchFromGitHub {
    owner = "lilendian0x00";
    repo = "xray-knife";
    rev = "v${version}";
    hash = "sha256-aqXPHGZH7QEHcr5H4jbkegCWHNSMhRnY0cOMeElkFyk=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-M+7l3V7HeGOphvDxhopAvq0v8DVpdTtWoH722rTAmTs=";

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
