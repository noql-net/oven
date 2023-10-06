{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mieru";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    hash = "sha256-xGKCK4M+xjuAWwvArb4eEZEed6zMdCU28KwV8z2VF64=";
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
