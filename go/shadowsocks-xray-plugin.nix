{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.8.24";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    hash = "sha256-UqtZf/H4qJ3NzGpMrW8TmmIrSus/P/LCZeXghDizGWc=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-Ka+RY7Twf6zJhr9mLeSo+0s84i20H8+bnVMar0GbUIM=";

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin";
    license = lib.licenses.mit;
  };
}
