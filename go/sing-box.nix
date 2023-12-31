{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "sing-box";
  version = "1.7.7";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    rev = "v${version}";
    hash = "sha256-EiWwy417PFMzk/v6mUCPuTW/xWicq7sqPZKpL+M3ZIo=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-cd0oN11YqgG8wJZJ4PiPaD1krKc2UcB0zngj9nTrpoY=";

  tags = [
    "with_gvisor"
    "with_quic"
    "with_wireguard"
    "with_grpc"
    "with_ech"
    "with_utls"
    "with_reality_server"
    "with_acme"
    "with_clash_api"
    "with_v2ray_api"
    "with_dhcp"
    # "with_embedded_tor" # needs cgo and depends on libs
    # "with_lwip" # needs cgo and depends on libs
  ];
  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/sagernet/sing-box/constant.Version=${version}"
  ];
  subPackages = [ "cmd/sing-box" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/SagerNet/sing-box";
    license = lib.licenses.gpl3Plus;
  };
}
