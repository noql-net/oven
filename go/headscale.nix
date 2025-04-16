{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "headscale";
  version = "0.22.3";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    hash = "sha256-nqmTqe3F3Oh8rnJH0clwACD/0RpqmfOMXNubr3C8rEc=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-IOkbbFtE6+tNKnglE/8ZuNxhPSnloqM2sLgTvagMmnc=";

  tags = [ "ts2019" ];
  ldflags = [
    "-s"
    "-w"
    "-X github.com/juanfont/headscale/cmd/headscale/cli.Version=${version}"
  ];
  subPackages = [ "cmd/headscale" ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/juanfont/headscale";
    license = lib.licenses.bsd3;
  };
}
