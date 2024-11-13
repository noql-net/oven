{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-knife";
  version = "2.13.18";

  src = fetchFromGitHub {
    owner = "lilendian0x00";
    repo = "xray-knife";
    rev = "v${version}";
    hash = "sha256-Qc5FaYaYKNzkktVX4KpXHjLycXhri6cw6d6iKGXHGQ0=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-HLWJRXMqehRjlBbJoadQHjsULMInB5hvahuV1dUNFKw=";

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
