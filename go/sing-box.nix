{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "sing-box";
  version = "1.1.7";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    rev = "v${version}";
    sha256 = "sha256-jovUK535vZeCgnnW+9/gjXwCkNLMXdiCJwWqFKCubcU=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-WYMCsFX5/4H+Bc0KcxcPMjfz2wEXz3V4D0sww15AgvE=";

  tags = [
    "with_gvisor"
    "with_quic"
    "with_wireguard"
    "with_grpc"
    "with_ech"
    "with_utls"
    "with_shadowsocksr"
    "with_acme"
    "with_clash_api"
    "with_v2ray_api"
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
