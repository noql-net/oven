{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "prometheus-blackbox-exporter";
  version = "0.24.0";

  src = fetchFromGitHub {
    owner = "prometheus";
    repo = "blackbox_exporter";
    rev = "v${version}";
    hash = "sha256-eoXSBliHadRGPT6+K75p2tEjKHKXmLz4svE59yQAEuM=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-yhgmJaWdYR5w5A8MVnHQS1yF6sTIMd1TOiesV4mc0Gs=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
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
