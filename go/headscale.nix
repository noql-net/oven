{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "headscale";
  version = "0.25.1";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    hash = "sha256-CrdMxRAgrDE1lJ3v9AhCN+cKOVqmIVwjE0x+msSVT+c=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-ZQj2A0GdLhHc7JLW7qgpGBveXXNWg9ueSG47OZQQXEw=";

  tags = [ "ts2019" ];
  ldflags = [
    "-s"
    "-w"
    "-X github.com/juanfont/headscale/cmd/headscale/cli.Version=${version}"
  ];
  subPackages = [ "cmd/headscale" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/juanfont/headscale";
    license = lib.licenses.bsd3;
  };
}
