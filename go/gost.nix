{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0-rc8";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    hash = "sha256-plFmQ/npIasPFpy8rKuHZFUKPsokiRep8j4N6Ls8PLo=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-KO+JmDoJDXgS4luXCzcawhMUr1+o0kRAjQA8+YiYVfM=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "cmd/gost" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/go-gost/gost";
    license = lib.licenses.mit;
  };
}
