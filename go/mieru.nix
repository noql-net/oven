{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mieru";
  version = "1.14.0";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    hash = "sha256-l3LHN2DXsCB24S6Yv6Vs9IlBXxK+/bNKpL4E3ymw57M=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-fC1bGgCeuqM77OJ9lnd+XsMyKQeFvPZaRKl/CFR64QU=";

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
