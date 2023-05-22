{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "headscale";
  version = "0.22.2";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    hash = "sha256-gA7xeHoRuRoZyCn5kZXPGA8+WduQeSEOBueH56b878o=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-cmDNYWYTgQp6CPgpL4d3TbkpAe7rhNAF+o8njJsgL7E=";

  tags = [ "ts2019" ];
  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/juanfont/headscale/cmd/headscale/cli.Version=${version}"
  ];
  subPackages = [ "cmd/headscale" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/juanfont/headscale";
    license = lib.licenses.bsd3;
  };
}
