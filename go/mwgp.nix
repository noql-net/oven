{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mwgp";
  version = "2.1.6";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "mwgp";
    rev = "v${version}";
    hash = "sha256-QCIZSPY4+ROhDw54OmXxk6phsSyC0vsSo7YiDoHGzB0=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-2ZmTk8njCCVv7Zs5MnVMyCwAG770QtuRMUyfy4c1Jw8=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.MWGPVersion=${version}"
  ];
  subPackages = [ "cmd/mwgp" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/apernet/mwgp";
    license = lib.licenses.mit;
  };
}
