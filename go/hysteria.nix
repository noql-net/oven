{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.5.2";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-ClWbA3cjQXK8tzXfmApBQ+TBnbRc6f36G1iIFcNQi7o=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  env.GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-IKcgfyeiQ+JbeKdnpM+MfEJ5hcAPMn0rLhsLqbcmXSY=";

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
