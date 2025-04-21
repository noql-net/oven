{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.25.0";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-6BZ1ZhlskvP1eYS/yMaPgR0gbAUDJS0rS3KId+Lq450=";
  };

  env.CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-WPfeelgKGY0zTfP19+x8PLBrCFpla2uJFstXxJM966o=";

  ldflags = [
    "-s"
    "-w"
  ];

  subPackages = [ "cmd/ooniprobe" ];
  doCheck = false;

  meta = {
    homepage = "https://github.com/ooni/probe-cli";
    license = lib.licenses.gpl3Plus;
  };
}
