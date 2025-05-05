{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "daze";
  version = "1.20.0";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "daze";
    rev = "v${version}";
    hash = "sha256-Rw5c6fi/XCT4VRPYkk9K9F4kV98//rN9JePfPX2+lWk=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/daze" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mohanson/daze";
    license = lib.licenses.mit;
  };
}
