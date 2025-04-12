{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "bepass";
  version = "1.6.2";

  src = fetchFromGitHub {
    owner = "bepass-org";
    repo = "bepass";
    rev = "v${version}";
    hash = "sha256-ruOhPWNs1WWM3r6X+6ch0HoDCu/a+IkBQiCr0Wh6yS8=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-X4iqM0/OI6yS/lBtXcBR80NFGgZ9675c+jFSpSy+eW4=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/cli" ];
  installPhase = ''
    install -Dm555 "$GOPATH"/bin/cli $out/bin/bepass
  '';


  doCheck = false;

  meta = {
    homepage = "https://github.com/bepass-org/bepass";
    license = lib.licenses.mit;
  };
}
