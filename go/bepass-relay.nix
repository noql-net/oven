{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "bepass-relay";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "bepass-org";
    repo = "bepass-relay";
    rev = "v${version}";
    hash = "sha256-PuswUhNUulUlWf2l7qDbg1J7K/v0ktOPio4TJgZ8/Xg=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-Z4ecObGWFKS/K3By4KH0uX/vMzmRYA4cNxkej/TQHQ4=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/bepass-org/bepass-relay";
    license = lib.licenses.mit;
  };
}
