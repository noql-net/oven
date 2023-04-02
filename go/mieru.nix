{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mieru";
  version = "1.13.0";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    sha256 = "sha256-M1Ly985tZZ/ean5P7uCwp49x7baoWlv4Ge3pjhb5k30=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-fC1bGgCeuqM77OJ9lnd+XsMyKQeFvPZaRKl/CFR64QU=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/mieru" "cmd/mita" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/enfein/mieru";
    license = lib.licenses.mit;
  };
}
