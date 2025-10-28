{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "gost";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    hash = "sha256-pdDCBknAXHIFD7vNkinsoq7Uec6g3VJsNNoE1lvKkW4=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-6oRw2tCiQFExWhF1l+vvbL1uoJNx+rzPz+LX2J5r4no=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/gost" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/go-gost/gost";
    license = lib.licenses.mit;
  };
}
