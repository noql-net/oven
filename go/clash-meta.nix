{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "clash-meta";
  version = "1.17.0";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "Clash.Meta";
    rev = "v${version}";
    hash = "sha256-F95QoxpnhgE3dlh5qmXp2HwtKoA6qU2chOX250eS8o0=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-/+X2eDCpo8AqWJ7rYbZrYzZapCgrdraTSx6BlWEUd78=";

  tags = [
    "with_gvisor"
    # "with_lwip"
  ];

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/Dreamacro/clash/constant.Version=${version}"
    "-X github.com/Dreamacro/clash/constant.BuildTime="
  ];
  subPackages = [ "." ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/clash $out/bin/clash-meta
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/MetaCubeX/Clash.Meta";
    license = lib.licenses.gpl3Plus;
  };
}
