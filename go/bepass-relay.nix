{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "bepass-relay";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "bepass-org";
    repo = "bepass-relay";
    rev = "v${version}";
    hash = "sha256-jAXnFOTNKdfPFnUAjwXtCRaOqNgjqyp01aTqAKOOq5w=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-sNkU+bidtqEUqXYri1lVaZ8Mrz88s16ZYoZTML+G5y4=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/bepass-org/bepass-relay";
    license = lib.licenses.mit;
  };
}
