{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash";
  version = "1.14.0";

  src = fetchFromGitHub {
    owner = "Dreamacro";
    repo = "clash";
    rev = "v${version}";
    hash = "sha256-w/Iz1PZekeKVGFHPteMEbjLP3V9qMmLLAz27qW0VtPk=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-raNFt+Ymh7m+p1wXy1ofMO1UJ2EouwaY7Ysngfw3X8U=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/Dreamacro/clash/constant.Version=${version}"
    "-X github.com/Dreamacro/clash/constant.BuildTime="
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Dreamacro/clash";
    license = lib.licenses.gpl3Plus;
  };
}
