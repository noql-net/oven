{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "sing-box";
  version = "1.8.10";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    rev = "v${version}";
    hash = "sha256-HKiTFDNzu42JNra7g+AyTxJ3RuHpvK7ONmKgk2nItT4=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-px90sebov5BbInJtRCGS30fyK3TThNN4XTMtdJhm0Uc=";

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
    "-X github.com/sagernet/sing-box/constant.Version=${version}"
  ];
  subPackages = [ "cmd/sing-box" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/SagerNet/sing-box";
    license = lib.licenses.gpl3Plus;
  };
}
