{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "go-shadowsocks2";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "shadowsocks";
    repo = "go-shadowsocks2";
    rev = "v${version}";
    hash = "sha256-z2+5q8XlxMN7x86IOMJ0qbrW4Wrm1gp8GWew51yBRFg=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-RrHksWET5kicbdQ5HRDWhNxx4rTi2zaVeaPoLdg4uQw=";

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/shadowsocks/go-shadowsocks2";
    license = lib.licenses.asl20;
  };
}
