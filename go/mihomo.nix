{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mihomo";
  version = "1.19.8";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "mihomo";
    rev = "v${version}";
    hash = "sha256-C8g2KhhXY11bqGKthNgiqdZwxoPVPhflhkh+X6JU33I=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-j97UFlcN8SfY6nireI6NDw8UcQuxyH34gue1Ywf25Yg=";

  tags = [
    "with_gvisor"
    # "with_lwip"
  ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/metacubex/mihomo/constant.Version=${version}"
    "-X github.com/metacubex/mihomo/constant.BuildTime="
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/MetaCubeX/mihomo";
    license = lib.licenses.gpl3Plus;
  };
}
