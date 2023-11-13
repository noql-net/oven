{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wiretap";
  version = "0.4.2";

  src = "${fetchFromGitHub {
    owner = "sandialabs";
    repo = "wiretap";
    rev = "v${version}";
    hash = "sha256-b9Yvua5vOrbej547mNCP5QgtaLf69T47GR2Ok5i22Y0=";
  }}/src";

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-/rITemxVMIPpNVbqnIJ+0NswlBU65qrVZEWWfk/sC8s=";

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
