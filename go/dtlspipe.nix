{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dtlspipe";
  version = "1.8.3";

  src = fetchFromGitHub {
    owner = "SenseUnit";
    repo = "dtlspipe";
    rev = "v${version}";
    hash = "sha256-ALsjdJsqaoKOUsB+r8+ACmZ8nC9Yw56wzuZ8fvggUIE=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-IsGYZO3FtMKzZAg1VybP1JhqKjKvzbWQ64qODttvSzE=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/dtlspipe" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/SenseUnit/dtlspipe";
    license = lib.licenses.mit;
  };
}
