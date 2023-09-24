{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.0.2";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-MMBDBWeOm0yiKNGe/Ywriv8oR0YoM3Or5uGGuePOV3U=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-nZNxMcMTnu9v/aD+wE8LyoVpxclEK3cYT3AklrLWd3U=";

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
