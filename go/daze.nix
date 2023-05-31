{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "daze";
  version = "1.19.0";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "daze";
    rev = "v${version}";
    hash = "sha256-HheitIdl7jGAOFICXpE4FckO9xGW0Khln8eyakkh3dw=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-0bVgdQLOukaTUhdOYA0uGXW0Ltw86417cIQiq+SjFV4=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "cmd/daze" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mohanson/daze";
    license = lib.licenses.mit;
  };
}
