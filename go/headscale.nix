{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "headscale";
  version = "0.24.3";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    hash = "sha256-G1MGu/AVFhiBOfhmhdH9+kayPybtsQsvj73omtZVfBU=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-SBfeixT8DQOrK2SWmHHSOBtzRdSZs+pwomHpw6Jd+qc=";

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
