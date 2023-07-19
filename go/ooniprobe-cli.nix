{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.18.1";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-abCglaMFW6zPc53IU8Bgl/SaoIh1N9i3xDcfOnJypls=";
  };

  CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-olirtvnOIKvNXJsanv5UFTcpj7RpPAa5OP0qYTv4wtk=";

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
