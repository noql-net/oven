{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "tun2socks";
  version = "2.5.1";

  src = fetchFromGitHub {
    owner = "xjasonlyu";
    repo = "tun2socks";
    rev = "v${version}";
    hash = "sha256-qRjVZF15CjFohv9PQO0bLAjS8ip//S7yncXOn9oS2XM=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-zeiOcn33PnyoseYb0wynkn7MfGp3rHEYBStY98C6aR8=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/xjasonlyu/tun2socks/v2/internal/version.Version=v${version}"
    "-X github.com/xjasonlyu/tun2socks/v2/internal/version.GitCommit=v${version}"
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/xjasonlyu/tun2socks";
    license = lib.licenses.gpl3Plus;
  };
}
