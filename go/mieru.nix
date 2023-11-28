{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mieru";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    hash = "sha256-yqR6dlMpNvEJIcEUXE9SD2bD6fuw2khXsA4LUl2T1Bs=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-N17h2Lpm6gxYhgouXpoAv+vs0Hk70w30SalclKsEPf0=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "cmd/mieru" "cmd/mita" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/enfein/mieru";
    license = lib.licenses.mit;
  };
}
