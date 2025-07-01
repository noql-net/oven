{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dnscrypt-proxy2";
  version = "2.1.11";

  src = fetchFromGitHub {
    owner = "DNSCrypt";
    repo = "dnscrypt-proxy";
    rev = "${version}";
    hash = "sha256-/2N7RqXR6UnxPy3b6d6qdL8TPZ9ShfZPoeJic/olA4U=";
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
