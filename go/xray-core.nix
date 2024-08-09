{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-core";
  version = "1.8.17";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    hash = "sha256-lWoL5P7ZpZYLqQGv4l/WusxXZ5wp3ojfd3gIX44pvG4=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-fywQD3WmWRi1gBGsVdk7bNCit7Y8o1QBvSfU1K6Ia58=";

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
