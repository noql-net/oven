{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mieru";
  version = "3.8.3";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    hash = "sha256-kmhqirVGBsffLx176tR3iU8EeHwlZ5n/ThXFvFZ9sww=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-Fu7mP6UV1D4QGbzC4pw6/3kh0ngH2BLzJmxkRepxpMI=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/mieru" "cmd/mita" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/enfein/mieru";
    license = lib.licenses.mit;
  };
}
