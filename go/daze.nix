{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "daze";
  version = "1.20.2";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "daze";
    rev = "v${version}";
    hash = "sha256-4qpJAINrgdbxIhh0xTIwRZkvr3PqiKsyRVgSqsVTlo4=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/daze" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mohanson/daze";
    license = lib.licenses.mit;
  };
}
