{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    hash = "sha256-ep3ZjD+eVKl3PuooDuYeur8xDAcyy6ww2I7f3cYG03o=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-lzyr6Q8yXsuer6dRUlwHEeBewjwGxDslueuvIiZUW70=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/gost" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/go-gost/gost";
    license = lib.licenses.mit;
  };
}
