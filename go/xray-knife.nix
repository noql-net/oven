{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-knife";
  version = "1.3.8";

  src = fetchFromGitHub {
    owner = "lilendian0x00";
    repo = "xray-knife";
    rev = "v${version}";
    hash = "sha256-+piOw/8Ii7FY1ywbmmtZn4UTgy0a1z86gbeyxz7R+WE=";
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
