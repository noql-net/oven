{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "sing-box";
  version = "1.9.6";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    rev = "v${version}";
    hash = "sha256-A9FfATNCS3UaW6YLORIApsgj0VK2jPyg+Ha2gcq6Keo=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-/lp+3mPkGMABpvnxqpuC/7NiKrmcEWYQ80Wb7Ng1eBI=";

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
