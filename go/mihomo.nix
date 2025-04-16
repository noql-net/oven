{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "mihomo";
  version = "1.19.0";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "mihomo";
    rev = "v${version}";
    hash = "sha256-SUXxNHsbqbRtky456irkFotjMlbXPuBhNrHHZABGbPM=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-whH9nEUddXd+xkgoCatkmfddTxK3BFZdi/TyTiabnDc=";

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
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/MetaCubeX/mihomo";
    license = lib.licenses.gpl3Plus;
  };
}
