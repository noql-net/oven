{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-sjQrHvUdGPdzKpXuJ9ZWp4S9pram8QaygKLT2WRmd2M=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-67dAdt30Lg1n/Ku8UXbG6RIutkbqZdq0Mod1g9BK9Zc=";

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
