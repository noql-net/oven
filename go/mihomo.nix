{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mihomo";
  version = "1.19.9";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "mihomo";
    rev = "v${version}";
    hash = "sha256-T1tg4sAR7OY3N6OheUySyQ0HLXYUBTLjeWx3qxHsb30=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-+7D2XAmN2AF2N1tmE1O7378duQYX5fgkUDxeO4n7Glk=";

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
