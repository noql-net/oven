{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-3ovJVo3Jqkq067XgDMxW5efCp6Ivfex4LbuUyR0cB8s=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-1dv34JYsnvCROp4JoejVbCzGpmFGBfoZHpeXgwgXErQ=";

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
