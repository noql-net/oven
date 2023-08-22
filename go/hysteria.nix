{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "1.3.5";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "v${version}";
    hash = "sha256-gNAK+WOowBlEzUYX25cQxywerNlMIx7cqG1wV9iLS5s=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-Vt2h6zmtLHQwXGTrrD3nqORRq3Mmdu+HWkSAjF5i8yo=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "cmd" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/cmd $out/bin/hysteria
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/apernet/hysteria";
    license = lib.licenses.mit;
  };
}
