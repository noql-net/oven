{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.6.1";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-0vd1cV2E07EntiOE0wHrSe4e/SRqbFrXhyBRFGxU7xY=";
  };

  sourceRoot = "source/app";

  env.CGO_ENABLED = 0;
  env.GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-Wtbiv65iDC+3jAfYyoZXjIrwI/nqNB0ZHzC1f12+nxc=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/apernet/hysteria/app/cmd.appVersion=${version}"
    "-X github.com/apernet/hysteria/app/cmd.appType=release"
  ];
  subPackages = [ "." ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/app $out/bin/hysteria
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/apernet/hysteria";
    license = lib.licenses.mit;
  };
}
