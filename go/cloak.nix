{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "cloak";
  version = "2.6.1";

  src = fetchFromGitHub {
    owner = "cbeuw";
    repo = "Cloak";
    rev = "v${version}";
    hash = "sha256-qbVDhvPw2+NnqozBtUb107ixGmz/lVLD5ySFAyWaTGw=";
  };

  patches = [
    ./cloak.patch
  ];

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-AER2yjnxfpkUI0VmNl5pwVKIvSJ6MWGVAm9iz9fWUoc=";

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
