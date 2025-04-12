{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "brook";
  version = "20240606";

  src = fetchFromGitHub {
    owner = "txthinking";
    repo = "brook";
    rev = "v${version}";
    hash = "sha256-rfCqYI0T/nbK+rlPGl5orLo3qHKITesdFNtXc/ECATA=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-dYiifLUOq6RKAVSXuoGlok9Jp8jHmbXN/EjQeQpoqWw=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cli/brook" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/txthinking/brook";
    license = lib.licenses.gpl3Plus;
  };
}
