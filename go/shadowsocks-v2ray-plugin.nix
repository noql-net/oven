{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "shadowsocks-v2ray-plugin";
  version = "5.12.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "v2ray-plugin";
    rev = "v${version}";
    hash = "sha256-GHYgo5wNgm24XzF+bvluYQy/oIYQtqMvLCudhWO5kUI=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-dTqRA23bzZWSzwughlb6kmNOEqgs6uzBU9gJvKhC7KU=";

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
