{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.27.0";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-kf+Nq8SrbGL0a9pmUsJChiXbb16IgaaNuDhr2k8Qzl0=";
  };

  env.CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-JnvP0PUOYNJLBpY9BWlC6cJ+Sor2gxDgSKJ8KnUctWc=";

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
