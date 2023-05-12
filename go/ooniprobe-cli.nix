{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.17.2";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-wPvWIeanozLQwgDlU3WR11NYhIpjw04vj7DlnFlacNw=";
  };

  CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-r8kyL9gpdDesY8Mbm4lONAhWC4We26Z9uG7QMt1JT9c=";

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
