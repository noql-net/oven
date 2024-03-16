{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "brook";
  version = "20240404";

  src = fetchFromGitHub {
    owner = "txthinking";
    repo = "brook";
    rev = "v${version}";
    hash = "sha256-QqA0LnbC72bnAQ25AehTnoXgdqQPc8wztHcFd4Q19ko=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-1aaOPeKHPrZO6WK08EhX4+dME0A33raQnbZi/aNFpIw=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cli/brook" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/txthinking/brook";
    license = lib.licenses.gpl3Plus;
  };
}
