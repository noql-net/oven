{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dive";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "wagoodman";
    repo = "dive";
    rev = "v${version}";
    hash = "sha256-9REthyb+bzsb7NBXkU9XyUZJFQHHrV1cG4//lTLgTgw=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-TaRq29VdwDe8qeZMBXqEGwmFSLpYd5C1wnf5cgJdKsU=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
    "-X main.commit="
    "-X main.buildTime="
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/wagoodman/dive";
    license = lib.licenses.mit;
  };
}
