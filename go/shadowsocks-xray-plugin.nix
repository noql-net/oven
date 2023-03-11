{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    sha256 = "sha256-Vl+wRtUzQ/RUINlH9Bwv3WW0o6vLSeukZKvc8mV5U2Q=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-A5If/BVDCQU/sFIWtyR7VPtPUwVML22McyB4fk3vkGc=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin";
    license = lib.licenses.mit;
  };
}
