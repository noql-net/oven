{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wiretap";
  version = "0.4.1";

  src = "${fetchFromGitHub {
    owner = "sandialabs";
    repo = "wiretap";
    rev = "v${version}";
    hash = "sha256-u9+R+JCbHXF/PzqNelATvS1Sg0+cnRHmIHkye5bswVI=";
  }}/src";

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-MgGBw/d9xCRwafOn8+GHdROOvyvg1LdZgKh+Y83Bg5k=";

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
