{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "gg";
  version = "0.2.19";

  src = fetchFromGitHub {
    owner = "mzz2017";
    repo = "gg";
    rev = "v${version}";
    hash = "sha256-DXW0NtFYvcCX4CgMs5/5HPaO9f9eFtw401wmJdCbHPU=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-fnM4ycqDyruCdCA1Cr4Ki48xeQiTG4l5dLVuAafEm14=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/mzz2017/gg/cmd.Version=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mzz2017/gg";
    license = lib.licenses.agpl3Plus;
  };
}
