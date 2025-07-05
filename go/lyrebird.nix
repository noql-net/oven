{ lib, buildGoModule, fetchFromGitLab, ... }:

buildGoModule rec {
  pname = "lyrebird";
  version = "0.4.0";

  src = fetchFromGitLab {
    domain = "gitlab.torproject.org";
    group = "tpo";
    owner = "anti-censorship/pluggable-transports";
    repo = "lyrebird";
    rev = "lyrebird-${version}";
    hash = "sha256-aPALWvngC/BVQO73yUAykHvEb6T0DZcGMowXINDqhpQ=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-iR3+ZMEF0SB3EoLTf2gtqTe3CQcjtDRhfwwbwGj3pXo=";

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
