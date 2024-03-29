{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "age";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "FiloSottile";
    repo = "age";
    rev = "v${version}";
    hash = "sha256-LRxxJQLQkzoCNYGS/XBixVmYXoZ1mPHKvFicPGXYLcw=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-XjJH3wyQXxj73JQUVkJFIBofijf+KERuRZ0gEhvhftA=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];
  subPackages = [ "cmd/..." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/FiloSottile/age";
    license = lib.licenses.bsd3;
  };
}
