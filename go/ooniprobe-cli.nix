{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.18.0";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-3KnPqUB9vNxIWF28BGZqqg1IwglHOP2qAZfDMaNcN7s=";
  };

  CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-iMEmTip9c7ySFUxcKr8ZUuREw7FfBvsIhECvmagvVL0=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];

  subPackages = [ "cmd/ooniprobe" ];
  doCheck = false;

  meta = {
    homepage = "https://github.com/ooni/probe-cli";
    license = lib.licenses.gpl3Plus;
  };
}
