{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-knife";
  version = "3.27.64";

  src = fetchFromGitHub {
    owner = "lilendian0x00";
    repo = "xray-knife";
    rev = "v${version}";
    hash = "sha256-J+ZY3lKB2Cy5LpORFzIfpbMPUaGh97lsLBMti7GZTcY=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-9JvUnflnTLl/BVTA7fmySM92S1XTgXv5CMRhwvIlcK8=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/lilendian0x00/xray-knife";
    license = lib.licenses.mit;
  };
}
