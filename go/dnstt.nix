{ lib, buildGoModule, fetchFromGit, ... }:

buildGoModule rec {
  pname = "dnstt";
  version = "82fb0a";

  src = fetchFromGit {
    url = "https://www.bamsoftware.com/git/dnstt.git";
    rev = "82fb0a6790d991ec74867cc2ca9b953e6bda4d13";
    sha256 = "sha256-/fd1CcG3srh6yHIy0kUuOQO/N18XR0FKWU4ODLzuu5g=";
  };

  vendorHash = "sha256-fWH2pwLRDemFZP3yqxG15YpvdtyIjJvpmLckhaloMvA=";

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  subPackages = [ "dnstt-client" "dnstt-server" ];

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;

  meta = {
    description = "Userspace DNS tunnel with support for DoH and DoT";
    homepage = "https://www.bamsoftware.com/software/dnstt/";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
