{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "glider";
  version = "0.16.3";

  src = fetchFromGitHub {
    owner = "nadoo";
    repo = "glider";
    rev = "v${version}";
    hash = "sha256-nM6jKFqyaxZbn0wyEt0xy9uTu9JyLRfGTNsGPTQOXQw=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-PGIBBop/waZDeQvW7iSi/AzLye/4t7nNXjX8zJsS2eo=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/nadoo/glider";
    license = lib.licenses.gpl3Plus;
  };
}
