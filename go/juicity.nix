{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "juicity";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "juicity";
    repo = "juicity";
    rev = "v${version}";
    hash = "sha256-CFytPXfmGNfKDbyYuMCr+4HiH37f28cTmng+XgnO6T0=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-PdX9GENqdTPpNWVRG3cTgZfAlEU85MVgDOJdcVT4gnw=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/juicity/juicity/config.Version=${version}"
  ];
  subPackages = [ "cmd/client" "cmd/server" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/client $out/bin/juicity-client
    install -Dm555 "$GOPATH"/bin/server $out/bin/juicity-server
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/juicity/juicity";
    license = lib.licenses.agpl3Plus;
  };
}
