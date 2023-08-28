{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "juicity";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "juicity";
    repo = "juicity";
    rev = "v${version}";
    hash = "sha256-+P7MFNhWI4aqCtcJhAw3/RtfOkh+b3v2v69pIOznc/8=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-SqSOwwdD2tKKiIsvizV5LjTZk7zBzLwMJMOc1hYTBjM=";

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
