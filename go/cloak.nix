{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "cloak";
  version = "2.11.0";

  src = fetchFromGitHub {
    owner = "cbeuw";
    repo = "Cloak";
    rev = "v${version}";
    hash = "sha256-afFOWjJiqlMeo8M8D2RsW572c2qTthMNbQvxEf7edHE=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-P3/fB1vJjEMETyFxH9XNQySCEDQWrbZdaf0V4qFucbI=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/ck-client " "cmd/ck-server" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/cbeuw/Cloak";
    license = lib.licenses.gpl3Plus;
  };
}
