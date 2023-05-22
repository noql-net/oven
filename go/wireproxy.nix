{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "wireproxy";
  version = "1.0.6";

  src = fetchFromGitHub {
    owner = "octeep";
    repo = "wireproxy";
    rev = "v${version}";
    hash = "sha256-Sy8jApnU3dpsXi5vWyEY6D250xpG73aByNZ/pSg90l0=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-LBLEb2oVi5ILNtoOtmJZ7NC7hMvLZcexYAxwmb4iUBo=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/wireproxy" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/octeep/wireproxy";
    license = lib.licenses.isc;
  };
}
