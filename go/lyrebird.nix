{ lib, buildGoModule, fetchFromGitLab, ... }:

buildGoModule rec {
  pname = "lyrebird";
  version = "0.3.0";

  src = fetchFromGitLab {
    domain = "gitlab.torproject.org";
    group = "tpo";
    owner = "anti-censorship/pluggable-transports";
    repo = "lyrebird";
    rev = "lyrebird-${version}";
    hash = "sha256-dDbb0obMVnp5lzAALnTwxcq9gw29vlv/JAuxHVCTtK4=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-2sMX0dG13DbjtSGDCaiQRw3AgEjiwxyxXBCIeFwgeg8=";

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
