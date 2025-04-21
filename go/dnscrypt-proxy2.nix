{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dnscrypt-proxy2";
  version = "2.1.8";

  src = fetchFromGitHub {
    owner = "DNSCrypt";
    repo = "dnscrypt-proxy";
    rev = "${version}";
    hash = "sha256-/D5RE8AbI9i9TVdFQCYW8OLPU4TgIIDRsZfWEyXo92g=";
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
