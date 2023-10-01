{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dtlspipe";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "Snawoot";
    repo = "dtlspipe";
    rev = "v${version}";
    hash = "sha256-nuVSEYbUWoPSmxch7JeaHbd0oc0XqBjZFQeUnLBMc48=";
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
