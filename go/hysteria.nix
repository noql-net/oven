{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.0.4";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-PrfrabCGj70H5+9BOCLpiUlahIwxbVAecYz2jqfrJrU=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-7kpeBrXD01rcUv8XfzT0MVhBwVDb/nnzxAwGtpwEMDI=";

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
