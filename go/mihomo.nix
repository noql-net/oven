{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mihomo";
  version = "1.18.0";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "mihomo";
    rev = "v${version}";
    hash = "sha256-lxiPrFPOPNppxdm2Ns4jaMHMRCYFlMz2h2rf7x0gv9c=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-b7q0e3HHolVhwNJF0kwvwuVy8ndJLc0ITMl+0/YtSjA=";

  tags = [
    "with_gvisor"
    # "with_lwip"
  ];

  ldflags = [
    "-s"
    "-w"
    "-buildid="
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
