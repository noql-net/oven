{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash-meta";
  version = "1.14.5";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "Clash.Meta";
    rev = "v${version}";
    hash = "sha256-5ZtxzgvUuM6ELF3kWTjkP3CxyjNnFoTt/rrWbj0T6Kk=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-VcT9dda5E9IMrDB/3QWBGWiNxGAEM2yKDbJwhGpN8og=";

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
