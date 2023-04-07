{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "tun2socks";
  version = "2.5.0";

  src = fetchFromGitHub {
    owner = "xjasonlyu";
    repo = "tun2socks";
    rev = "v${version}";
    sha256 = "sha256-uu0FBhckZ06eXEEuKwN3MopGMDbMjjcABYa/lgM48n4=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-QIXgRoxmJaeYGx77EB53zIb94InlQbUSOXE+cUdBttI=";

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
