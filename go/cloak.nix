{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "cloak";
  version = "2.8.0";

  src = fetchFromGitHub {
    owner = "cbeuw";
    repo = "Cloak";
    rev = "v${version}";
    hash = "sha256-5UmJSeqRj71lHHiGcJO+RdeVg7GWDETsFrqnvzDvkpg=";
  };

  patches = [
    ./cloak.patch
  ];

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-oc208yCRt0Dk87b/KVjiJxWKbN9IrYIOr05RTEDMhPU=";

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
