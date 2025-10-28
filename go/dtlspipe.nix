{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dtlspipe";
  version = "1.8.2";

  src = fetchFromGitHub {
    owner = "SenseUnit";
    repo = "dtlspipe";
    rev = "v${version}";
    hash = "sha256-hPxcQmQLDjmjrVpyVEc3m4shbL2k1UzauDfBF0syQ4k=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-+Vycd4MNJ44nr19Dp5WjI4wSmxP7uoLra/mH4Xu6T/k=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/dtlspipe" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/SenseUnit/dtlspipe";
    license = lib.licenses.mit;
  };
}
