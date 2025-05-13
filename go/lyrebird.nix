{ lib, buildGoModule, fetchFromGitLab, ... }:

buildGoModule rec {
  pname = "lyrebird";
  version = "0.6.0";

  src = fetchFromGitLab {
    domain = "gitlab.torproject.org";
    group = "tpo";
    owner = "anti-censorship/pluggable-transports";
    repo = "lyrebird";
    rev = "lyrebird-${version}";
    hash = "sha256-YIm8e65QDHKfLz6okAETQ3Ec57AJ8X8qGxBocaalEcI=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-KST1hiznCf8uc6s6JSQ0oX2Va7iz/SZ1TlGzfMdZVlI=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/lyrebird" ];

  doCheck = false;

  meta = {
    homepage = "https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/lyrebird";
    license = lib.licenses.gpl3Plus;
  };
}
