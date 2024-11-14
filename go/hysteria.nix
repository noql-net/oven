{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.5.1";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-ynG06sthqsKNGJdraHg8EkWNENfiv7E0O33wTKy2QG4=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  env.GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-WegS8WUqVR4CUPAfy0grVVIpdmB0wnW4KRPh+N3DKOc=";

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
