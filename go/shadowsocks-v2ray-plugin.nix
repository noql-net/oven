{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-v2ray-plugin";
  version = "5.5.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "v2ray-plugin";
    rev = "v${version}";
    hash = "sha256-G1YtY2q9QNwmiOP6y7DjIIyvqbECZzDDtkl7zbkc9T8=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-YnU0BMWqYq5upcdd9kT42suqX03s4UZA8gvK0pt88E8=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/v2ray-plugin";
    license = lib.licenses.mit;
  };
}
