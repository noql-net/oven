{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "outline-ss-server";
  version = "1.9.0";

  src = fetchFromGitHub {
    owner = "Jigsaw-Code";
    repo = "outline-ss-server";
    rev = "v${version}";
    hash = "sha256-G4lvJZUfuaJOVH51f6NjyQHGJbO3VV2fVsxiKJf6+7A=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-nwYLtu3VmQfELUAKyFfMVfg2BscWALk5PqBgzJnlrxA=";

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
