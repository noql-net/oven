{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "gost";
  version = "3.2.5";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    hash = "sha256-voVk4zzNm2UZWQ3c/n0YOwuaE9JcIlEmJ881nTXXyrY=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-73gjw0oW8i7Vp6ZxxqkO42/atdde4J+lu/pCHK/xY+8=";

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
