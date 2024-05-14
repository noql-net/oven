{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wireproxy";
  version = "1.0.9";

  src = fetchFromGitHub {
    owner = "octeep";
    repo = "wireproxy";
    rev = "v${version}";
    hash = "sha256-VPIEgvUg0h80Cd611zXQ5mhamfJTQpaDK9kiUMy2G0A=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-DNTPzZSxcjkcv7RygTpOIgdYEQ8wBPkuJqfzZGt8ExI=";

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
