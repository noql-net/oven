{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.17.3";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-kqjTYowAEfJ+um9DQQXIMLVWlEGJ9intbdTSJukSvVc=";
  };

  CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-kS5HWiATn2WT6E5gb0Gve83hHJ++xHmPSsgJu/5GqO4=";

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
