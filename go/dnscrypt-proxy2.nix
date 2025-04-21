{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dnscrypt-proxy2";
  version = "2.1.6";

  src = fetchFromGitHub {
    owner = "DNSCrypt";
    repo = "dnscrypt-proxy";
    rev = "${version}";
    hash = "sha256-PtZHtUq384KsATcMfTW11erlZVBm/qs7RpwsplIzOus=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/DNSCrypt/dnscrypt-proxy";
    license = lib.licenses.isc;
  };
}
