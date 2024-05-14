{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wireproxy";
  version = "1.0.8";

  src = fetchFromGitHub {
    owner = "octeep";
    repo = "wireproxy";
    rev = "v${version}";
    hash = "sha256-2gio+kyjIvaNjb/+M8M5YvbAPbQX+B9A/Qly2kyFZXw=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-u5/ppH+8mcR3AdPnA6vDFL4GwVzbUj679I4zBw80HU0=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/wireproxy" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/octeep/wireproxy";
    license = lib.licenses.isc;
  };
}
