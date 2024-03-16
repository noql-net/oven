{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dtlspipe";
  version = "1.7.3";

  src = fetchFromGitHub {
    owner = "Snawoot";
    repo = "dtlspipe";
    rev = "v${version}";
    hash = "sha256-pYCvVmUebW6Q5YCs65TkcLIKgjxjgIEEjukVtQYK4bM=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-pyfzH+kCFFer4GVs2+7451ek6NQ9BK44TstQS+om9z8=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/dtlspipe" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Snawoot/dtlspipe";
    license = lib.licenses.mit;
  };
}
