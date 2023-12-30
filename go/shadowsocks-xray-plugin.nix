{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.8.6";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    hash = "sha256-EBg3aGbQtZ0V64nvVdgC6GozEDDjXAbpJNvd8fzsBYQ=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-9b9wa/pCgyfF9fVl9EC+PMcr9E7OhGMeEX83CxgkSMI=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin";
    license = lib.licenses.mit;
  };
}
