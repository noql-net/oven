{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "clash";
  version = "1.17.0";

  src = fetchFromGitHub {
    owner = "Dreamacro";
    repo = "clash";
    rev = "v${version}";
    hash = "sha256-hUkUfNsThir0txO7cdxJl3sUF8/wHDvDPVspGp5xYUQ=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-M2hoorCBdq2nm5Gc5Xm6r7Cg9XUOirDyqTKwrmu121s=";

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
