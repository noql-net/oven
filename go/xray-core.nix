{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "xray-core";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    hash = "sha256-yvfBrMQPvIzuLT9wAvQ9QdAIfjzFt7B+L4N8q9SwufA=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-mr07woy6QXRz8iM4Yzl1Wv5+jlG7ws/fDAnuHjNiUPc=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/xray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/XTLS/Xray-core";
    license = lib.licenses.mpl20;
  };
}
