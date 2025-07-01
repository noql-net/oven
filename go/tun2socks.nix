{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "tun2socks";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "xjasonlyu";
    repo = "tun2socks";
    rev = "v${version}";
    hash = "sha256-ec4M107BE6MCnW/uz9S83JYJtY9tsQQXDFL98h951DA=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-YAAdyV2p/Ci9RzgVWYXBwR/ctERSQ8SPK7AbwRuUJiI=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/xjasonlyu/tun2socks/v2/internal/version.Version=v${version}"
    "-X github.com/xjasonlyu/tun2socks/v2/internal/version.GitCommit=v${version}"
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/xjasonlyu/tun2socks";
    license = lib.licenses.mit;
  };
}
