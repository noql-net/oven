{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dive";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "wagoodman";
    repo = "dive";
    rev = "v${version}";
    hash = "sha256-eg9qvCIM9HJPwmSXAcnktVdLKi3y5e9H1xq4i3QQgx8=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-CiUBwJR1TTJw3r1//axtutcvATWIp9IpN9RBlC/MJ2k=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
    "-X main.commit="
    "-X main.buildTime="
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/wagoodman/dive";
    license = lib.licenses.mit;
  };
}
