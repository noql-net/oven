{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.8.9";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    hash = "sha256-oEI/2KWEMWHyDKK+f675Sx075jcvrt9bAs7N7eXaM0g=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-Kf4Bx2eO41+dvSC+pLpjW0kv+JOg+5TEQ50sY8GVJgY=";

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
