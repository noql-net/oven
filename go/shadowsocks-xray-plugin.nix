{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    sha256 = "sha256-R6VjnqPgXnSWFvyF9vkLZXikwFRfDA8h8h93yq6oTjA=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-yLWR+19DiJLzg3ak8th04n22sCtFkHfCx0JY7uqU3f8=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin";
    license = lib.licenses.mit;
  };
}
