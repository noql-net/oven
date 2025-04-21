{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-core";
  version = "24.12.31";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    hash = "sha256-831T8TxxHEjpHBNnHBqgUFSqX1JRj/BIpLdJd1XJTww=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-n6ivMxZvw0wtWzxfnOJAmiLjIEPgvjHhVXsoY9lO8GQ=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/xray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/XTLS/Xray-core";
    license = lib.licenses.mpl20;
  };
}
