{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "brook";
  version = "20230401";

  src = fetchFromGitHub {
    owner = "txthinking";
    repo = "brook";
    rev = "v${version}";
    sha256 = "sha256-PVkdK1wcY3PaeixEG4StV1AmYPit6pQNErcALmV2LXc=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-7h+rMfFFpcsfZa6tw/o0uRIDw4g3g+dwd9y2Ysg2NJc=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cli/brook" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/txthinking/brook";
    license = lib.licenses.gpl3Plus;
  };
}
