{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wiretap";
  version = "0.4.4";

  src = "${fetchFromGitHub {
    owner = "sandialabs";
    repo = "wiretap";
    rev = "v${version}";
    hash = "sha256-b9Yvua5vOrbej547mNCP5QgtaLf69T47GR2Ok5i22Y0=";
  }}/src";

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-+/YD2B5Q1dLf+zTE1MyZmIWude0MsZHPPSK2FpROuW4=";

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
