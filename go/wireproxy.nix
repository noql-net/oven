{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wireproxy";
  version = "1.0.7";

  src = fetchFromGitHub {
    owner = "octeep";
    repo = "wireproxy";
    rev = "v${version}";
    hash = "sha256-lMTlocKtOg82dH8XU+bIgPhico3mueLAuTspAY88GFI=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-V9W7Z8vgPdudNivfmGzJe1f6ebrZEqlG4AdIf2NNGrY=";

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
