{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dtlspipe";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "Snawoot";
    repo = "dtlspipe";
    rev = "v${version}";
    hash = "sha256-+fQNmeGFArgO/3rS5Kmgqt4p/f9jEExVcIXDPbjtRa8=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-SJlEYh1ZmKphwjwxJmuj4OBw2X9EkS9BwkidOTXED1Y=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/dtlspipe" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Snawoot/dtlspipe";
    license = lib.licenses.mit;
  };
}
