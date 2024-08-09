{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mihomo";
  version = "1.18.5";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "mihomo";
    rev = "v${version}";
    hash = "sha256-YNnZ/wlOzmTAD76py4CRlClPi2S1b4PaanCfT/Q426A=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-yBQ4Nt03VS2em6vkzMa1WH9jHc6pwdlW0tt9cth55oQ=";

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
