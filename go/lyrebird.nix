{ lib, buildGoModule, fetchFromGitLab, ... }:

buildGoModule rec {
  pname = "lyrebird";
  version = "0.2.0";

  src = fetchFromGitLab {
    domain = "gitlab.torproject.org";
    group = "tpo";
    owner = "anti-censorship/pluggable-transports";
    repo = "lyrebird";
    rev = "lyrebird-${version}";
    hash = "sha256-Eon5gZsvpXzOMPZCx2aVh+b692Ir0EfOnavORkNwrUY=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-DLyICc7sFjmdYsIsnHOHJGDiAvIzs8f5Na/waUBGkUA=";

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
