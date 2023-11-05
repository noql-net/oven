{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "shadowsocks-v2ray-plugin";
  version = "5.11.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "v2ray-plugin";
    rev = "v${version}";
    hash = "sha256-1XZg3navUwIldeshrQc1MxjO3N1Pp59pny931OwFzkM=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-LXJMljYT2iaWJbW7Hu3fpl/B3AxX4IJylhTRV4VXcfU=";

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
