{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "cloak";
  version = "2.7.0";

  src = fetchFromGitHub {
    owner = "cbeuw";
    repo = "Cloak";
    rev = "v${version}";
    hash = "sha256-nhJmGUqWkIMIs9u7zKVfNrUgG3Nxw1cn8wQaFf6Qd9w=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-ICNWRb7oUL2ojd5f5Cyqhb9wo2ruNniIbjxkIf5brt8=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/ck-client " "cmd/ck-server" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/cbeuw/Cloak";
    license = lib.licenses.gpl3Plus;
  };
}
