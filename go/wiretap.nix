{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wiretap";
  version = "0.5.0";

  src = "${fetchFromGitHub {
    owner = "sandialabs";
    repo = "wiretap";
    rev = "v${version}";
    hash = "sha256-C2J/Q5b4MJiHrVC+NUQGLZPcAVxduPP8lB0MtGK+pr8=";
  }}/src";

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-cpJ/1nJDQzMiPP+uB8vRkan1MwzIpWcJYaYQv6KB6+o=";

  ldflags = [
    "-s"
    "-w"
    "-X wiretap/cmd.Version=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/sandialabs/wiretap";
    license = lib.licenses.mit;
  };
}
