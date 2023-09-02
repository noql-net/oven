{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dtlspipe";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "Snawoot";
    repo = "dtlspipe";
    rev = "v${version}";
    hash = "sha256-fGLa6KSpSOUWiYsKk7Rwl6RIrqYJ7qm4SmEAU2FqQD4=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-YUfn01nsJSu/nSPPxwU/DwXwrO2defD6iGKuOndd95A=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/dtlspipe" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Snawoot/dtlspipe";
    license = lib.licenses.mit;
  };
}
