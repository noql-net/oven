{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0-rc7";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    hash = "sha256-xU6i6DywV7zCxGg+x4uKkvad8OUKeDffCCkOZ9fT3kM=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-GctiUzzMg6VS3BSXAxn8CwHq+Z4SKz725WJKcPmCGsQ=";

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
