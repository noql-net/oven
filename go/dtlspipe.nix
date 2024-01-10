{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dtlspipe";
  version = "1.7.2";

  src = fetchFromGitHub {
    owner = "Snawoot";
    repo = "dtlspipe";
    rev = "v${version}";
    hash = "sha256-gKGqsusmPYECDm82l2DDZc9vQNEOoy9YnQ5Vka1U5eo=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-W5tgXl1DqRUnacxt0xxo/0FCfN/GHvFoLRV49YNHrmQ=";

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
