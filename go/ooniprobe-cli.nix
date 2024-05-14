{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.21.1";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-H5QlyxNQdKGoTIdfh/neULakTddVIhXgMJ/wLbqvGbY=";
  };

  CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-I88cALmc8iTaVJ36ntQLw+wRMM2GLWMWLhv8EDJDRgg=";

  ldflags = [
    "-s"
    "-w"
  ];

  subPackages = [ "cmd/ooniprobe" ];
  doCheck = false;

  meta = {
    homepage = "https://github.com/ooni/probe-cli";
    license = lib.licenses.gpl3Plus;
  };
}
