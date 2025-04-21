{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-knife";
  version = "2.14.21";

  src = fetchFromGitHub {
    owner = "lilendian0x00";
    repo = "xray-knife";
    rev = "v${version}";
    hash = "sha256-Rfcvd+mElFlEs15wT+jBw+Ns9d6wOGhOVBbL7RAsgZI=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-BifOJl6p77L97d4JAoPrRqMXPipVsar0GCRdhEB0gMM=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/lilendian0x00/xray-knife";
    license = lib.licenses.mit;
  };
}
