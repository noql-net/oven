{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash-meta";
  version = "1.14.3";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "Clash.Meta";
    rev = "v${version}";
    hash = "sha256-FGmUzv9Ae2dn6vqlAXcpM5xs1K8P4tGn5tchl7N2rqg=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-D6b0U04wwDUzeIu3//E10YehohTzvyHWtK5Yzf3xrAI=";

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
