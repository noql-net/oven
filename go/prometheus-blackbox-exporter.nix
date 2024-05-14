{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "prometheus-blackbox-exporter";
  version = "0.25.0";

  src = fetchFromGitHub {
    owner = "prometheus";
    repo = "blackbox_exporter";
    rev = "v${version}";
    hash = "sha256-RyVP/lcCN/HbhRtGM7n4kFRpBxMO5SvpleeygzCq5bA=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-gVVYccbwtB9/WA3lfzXwI9cZkTdTv96/2gLfwtoE+WM=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/prometheus/common/version.Version=${version}"
    "-X github.com/prometheus/common/version.Revision=v${version}"
    "-X github.com/prometheus/common/version.Branch=unknown"
    "-X github.com/prometheus/common/version.BuildUser=unknown"
    "-X github.com/prometheus/common/version.BuildDate=unknown"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/prometheus/blackbox_exporter";
    license = lib.licenses.asl20;
  };
}
