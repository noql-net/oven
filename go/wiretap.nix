{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wiretap";
  version = "0.6.0";

  src = "${fetchFromGitHub {
    owner = "sandialabs";
    repo = "wiretap";
    rev = "v${version}";
    hash = "sha256-fRDuCrshlb430/97NdXfqPPTIcZFJZxmdqGdY6HFuJM=";
  }}/src";

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-ieKQW3tONDXfIXcQjt+NombhlOralHlEVAIzCc0ssxg=";

  ldflags = [
    "-s"
    "-w"
    "-X wiretap/cmd.Version=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/sandialabs/wiretap";
    license = lib.licenses.mit;
  };
}
