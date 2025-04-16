{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "mwgp";
  version = "2.1.7";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "mwgp";
    rev = "v${version}";
    hash = "sha256-MZD0uKts3xWI55ac+6oBlC9JlMEBMNmq69Lebq74dXg=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-fkx825u64bSc67pQpitnA+86vEO6xda5mfV9ivbn0XQ=";

  ldflags = [
    "-s"
    "-w"
    "-X main.MWGPVersion=${version}"
  ];
  subPackages = [ "cmd/mwgp" ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/apernet/mwgp";
    license = lib.licenses.mit;
  };
}
