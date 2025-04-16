{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "dnscrypt-proxy2";
  version = "2.1.5";

  src = fetchFromGitHub {
    owner = "DNSCrypt";
    repo = "dnscrypt-proxy";
    rev = "${version}";
    hash = "sha256-A9Cu4wcJxrptd9CpgXw4eyMX2nmNAogYBRDeeAjpEZY=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/DNSCrypt/dnscrypt-proxy";
    license = lib.licenses.isc;
  };
}
