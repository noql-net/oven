{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0-rc10";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    hash = "sha256-o0lE6grS7beslw/O0AtmPxeWlA4z8XAaLlo41U6zAsg=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-C4HPOPveU+pOd8gyZWSo9R5EAHh+RvrfqtlpiJoeW84=";

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
