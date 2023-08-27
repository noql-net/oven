{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wiretap";
  version = "0.4.0";

  src = "${fetchFromGitHub {
    owner = "sandialabs";
    repo = "wiretap";
    rev = "v${version}";
    hash = "sha256-W5mLLBs4Efj6altr+QheWV4H9TA/J7s8gsxZsAz2iqQ=";
  }}/src";

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-WiB17QcSAUY0LcjCpjnccg4YJv3dWvJdRSX028spKwQ=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X wiretap/cmd.Version=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/sandialabs/wiretap";
    license = lib.licenses.mit;
  };
}
