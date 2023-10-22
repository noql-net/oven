{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mieru";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    hash = "sha256-CoeIY7kd8ix0mB+i5or7Vz0+5vjct76ic/OT71SlMRA=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-GWEdTcrxjnV6Nm7iHA9RQkFYcnyTr4YowEV/+5azkH8=";

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
