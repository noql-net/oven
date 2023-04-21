{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "headscale";
  version = "0.22.1";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    sha256 = "sha256-6T4wWuhikanoQGGjVvNJak5yvgcEfhGtOmfLc2xKmms=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-+JxS4Q6rTpdBwms2nkVDY/Kluv2qu2T0BaOIjfeX85M=";

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
