{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "daze";
  version = "1.24.2";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "daze";
    rev = "v${version}";
    hash = "sha256-a3N9KSjDB/A8dhdH6SFdsNOODVQnVNnZxglSxaLT1JM=";
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
