{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-knife";
  version = "7.0.1";

  src = fetchFromGitHub {
    owner = "lilendian0x00";
    repo = "xray-knife";
    rev = "v${version}";
    hash = "sha256-38QGBhIa8/WbcSvexiD1bZN9RpqURGoKUUrBdBdLAsU=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-kbbthWXtlkoQtCvf8vQNfiZgEgAM0fDRtTbFRQbnl6A=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/lilendian0x00/xray-knife";
    license = lib.licenses.mit;
  };
}
