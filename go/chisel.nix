{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "chisel";
  version = "1.10.0";

  src = fetchFromGitHub {
    owner = "jpillora";
    repo = "chisel";
    rev = "v${version}";
    hash = "sha256-lcMIPASzP1u+MYuozczWFkimBS0XPbrvsy1OldPtRsA=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-+11Pd/QCxoLLkeazmU9/vnPBaB2MZXmx4cEZRDnyRcQ=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/jpillora/chisel/share.BuildVersion=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/jpillora/chisel";
    license = lib.licenses.mit;
  };
}
