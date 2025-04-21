{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mihomo";
  version = "1.19.3";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "mihomo";
    rev = "v${version}";
    hash = "sha256-NzxH6rgr85oHmkMxh3rLbYXJoQKOsngeTazAV3SvRCg=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-dQNdOTFcfk53Snu01XLGB3PTiU1Ex/QQvykfopIdk2M=";

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
