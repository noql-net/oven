{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "daze";
  version = "1.21.2";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "daze";
    rev = "v${version}";
    hash = "sha256-NWWLUeegamfRPtaajxfSF6R10pPa2R6A7wmd7nH8EKE=";
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
