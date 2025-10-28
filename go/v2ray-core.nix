{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.41.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-SHmcjpxqTyTm/jHbAwm5hD2s9Kg/YdhmpQqa6iwpHCI=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-5YSVjZ14/vQA8MZA/imVkcHMAvaaMHbR6/+4Dzwejfo=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/v2ray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/v2fly/v2ray-core";
    license = lib.licenses.mit;
  };
}
