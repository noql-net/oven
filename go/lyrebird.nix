{ lib, buildGoModule, fetchFromGitLab, ... }:

buildGoModule rec {
  pname = "lyrebird";
  version = "0.1.0";

  src = fetchFromGitLab {
    domain = "gitlab.torproject.org";
    group = "tpo";
    owner = "anti-censorship/pluggable-transports";
    repo = "lyrebird";
    rev = "lyrebird-${version}";
    hash = "sha256-2qBSmAsaR3hfxuoR5U5UAFQAepUOEUnIGoxc/GZ5LmY=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-O8CsvpwL9cfipl4M0BquSnG9tBrt/+i+i80OYk2mNiI=";

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
