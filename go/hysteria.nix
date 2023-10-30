{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-v9W1/1AIcYKYxVnFFXZdwQC50FWJCMQ0OXCmlfmXWQk=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-jSJYI5WP6eFX0wc1P2e3z7fioT65dCA4XJdIZdeOZKo=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
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
