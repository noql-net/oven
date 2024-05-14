{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.8.10";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    hash = "sha256-qyrNBXiL3w3X55NVRtt7JZ5zntFXf6zJ0/VDAwMX8fI=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-L+aAR9Q2jISwphr/zqYfEcHADoz62zwlbSu165tKPtM=";

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
