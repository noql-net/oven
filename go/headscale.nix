{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "headscale";
  version = "0.23.0";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    hash = "sha256-5tlnVNpn+hJayxHjTpbOO3kRInOYOFz0pe9pwjXZlBE=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-+8dOxPG/Q+wuHgRwwWqdphHOuop0W9dVyClyQuh7aRc=";

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
