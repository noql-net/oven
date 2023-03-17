{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "hysteria";
  version = "1.3.4";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "v${version}";
    sha256 = "sha256-Xmc6xkOepvLDHcIHaYyJIO2e3yIWQxPEacS7Wx09eAM=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";

  vendorSha256 = "sha256-nG9mzQJGbk1Rf9ATER+p5cH74mgj4USaZVpnkUc0i98=";

  ldflags = [ "-s" "-w" "-buildid=" ];
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
