{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "prometheus-alertmanager";
  version = "0.26.0";

  src = fetchFromGitHub {
    owner = "prometheus";
    repo = "alertmanager";
    rev = "v${version}";
    hash = "sha256-DCVxXSgoa4PrW4qBBWa1SOPN1GwcJFERz7+itsCdtGI=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-GCcoT7Db0bQf+IGUP54GdxRmHCp1k2261B3T2htmbjk=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/prometheus/common/version.Version=${version}"
    "-X github.com/prometheus/common/version.Revision=v${version}"
    "-X github.com/prometheus/common/version.Branch=unknown"
    "-X github.com/prometheus/common/version.BuildUser=unknown"
    "-X github.com/prometheus/common/version.BuildDate=unknown"
  ];
  subPackages = [ "cmd/alertmanager" "cmd/amtool" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/prometheus/alertmanager";
    license = lib.licenses.asl20;
  };
}
