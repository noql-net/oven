{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.19.0";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-W3C4KbZnOdljofnlYZk/F6E77/AXjdNTRoWrtoEVfqg=";
  };

  CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-wEhh0nMdFH9wLfNSxYvbkbtu69cNEmVpQDk57/gdnw8=";

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
