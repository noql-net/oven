{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.8.15";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    hash = "sha256-vczlNr0z0UM36ZZyaSGGSFyx+eqYRKCgYHt9kXFsYok=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-YCrbXsC7MCFJJCkR9FyOahcdoCReGF+wXX0NVBej5oM=";

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin";
    license = lib.licenses.mit;
  };
}
