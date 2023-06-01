{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.7.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-gdDV5Cd/DjEqSiOF7j5a8QLtdJiFeNCnHoA4XD+yiGA=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-uq0v14cRGmstJabrERsa+vFRX6Bg8+5CU6iV8swrL/I=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
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
