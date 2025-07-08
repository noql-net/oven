{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-knife";
  version = "5.5.8";

  src = fetchFromGitHub {
    owner = "lilendian0x00";
    repo = "xray-knife";
    rev = "v${version}";
    hash = "sha256-69HHAwIxO7TJ7O4ah0uJb6VunqRC8w9D2BAhwH+13eA=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-PcZj3jaU7Pi5CgpTS8eB1KAh/dnUGXo2dve9dNqHIEU=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/lilendian0x00/xray-knife";
    license = lib.licenses.mit;
  };
}
