{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "psiphon-tunnel-core";
  version = "2.0.29";

  src = fetchFromGitHub {
    owner = "Psiphon-Labs";
    repo = "psiphon-tunnel-core";
    rev = "v${version}";
    sha256 = "sha256-JI63CeG7pxdUOOjWyhKSsjvkkpiNM2caqI7NeS4HtdQ=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = null;

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/Psiphon-Labs/psiphon-tunnel-core/psiphon/common/buildinfo.buildDate="
    "-X github.com/Psiphon-Labs/psiphon-tunnel-core/psiphon/common/buildinfo.buildRepo="
    "-X github.com/Psiphon-Labs/psiphon-tunnel-core/psiphon/common/buildinfo.buildRev=${version}"
    "-X github.com/Psiphon-Labs/psiphon-tunnel-core/psiphon/common/buildinfo.goVersion="
  ];
  subPackages = [ "ConsoleClient" "Server" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/ConsoleClient $out/bin/psiphon-tunnel-core
    install -Dm555 "$GOPATH"/bin/Server $out/bin/psiphond
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/Psiphon-Labs/psiphon-tunnel-core";
    license = lib.licenses.gpl3Plus;
  };
}
