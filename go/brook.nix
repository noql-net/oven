{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "brook";
  version = "20230601";

  src = fetchFromGitHub {
    owner = "txthinking";
    repo = "brook";
    rev = "v${version}";
    hash = "sha256-Y7uaLKxDu7C8ySfTplKWdXBJdUhUXVeVPQJqSzvvywY=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-uKlO1x5sGM8B1htmvRt9kND7tuH36iLN/Mev77vwZ6M=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "cli/brook" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/txthinking/brook";
    license = lib.licenses.gpl3Plus;
  };
}
