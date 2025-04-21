{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "outline-ss-server";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "Jigsaw-Code";
    repo = "outline-ss-server";
    rev = "v${version}";
    hash = "sha256-o6ZVIfSvhF7PkMov1WtHrn3hWk/rqT3tDjge/hfJE9k=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-/hPh/4805S9B8PlTDcNNRegTr4NZ+QaYq6BqI0SYlnQ=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/..." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Jigsaw-Code/outline-ss-server";
    license = lib.licenses.asl20;
  };
}
