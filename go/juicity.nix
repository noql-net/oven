{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "juicity";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "juicity";
    repo = "juicity";
    rev = "v${version}";
    hash = "sha256-UKEmPb5Kn2GlTriXFOavQ5o8bU9VqMzQZx4iyG5W7a0=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-tlO4/pmlUHk2sAkrcOMy8nBIsVDrfCXTyH9dsIv6PPs=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
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
