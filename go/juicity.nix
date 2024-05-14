{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "juicity";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "juicity";
    repo = "juicity";
    rev = "v${version}";
    hash = "sha256-JC4VGM7aY+fYo0F9yAkgTbZA56ztyeoIx9PARlBjkh4=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-uULJKg1nh6jU0uIgDf4GMu8O00zifLvU2wv65dlHLAs=";

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
