{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "gost";
  version = "3.2.4";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    hash = "sha256-zFGoM+fYO/o70LJ2fbzhMv4qbjLozJGmGbudqHjCFRU=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-W3CHttD9iGpl2wG/Pa21YY6ACf5M894p25nLfMX0+F4=";

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
