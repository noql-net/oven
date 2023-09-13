{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "daze";
  version = "1.19.6";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "daze";
    rev = "v${version}";
    hash = "sha256-HQ61ryUbnRjTkoB6MkJ/YRUxP1vOPyK6cVR9rbFlSvk=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "cmd/daze" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mohanson/daze";
    license = lib.licenses.mit;
  };
}
