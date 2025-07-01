{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.35.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-h0b4AenbqPDc1nAkWc6hke8sLm5BXzsp0oK+4KRib/Y=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-rBIDiWTrPRFLMYZcWubaynZmj7FThUUKlb16ZQLhee4=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/v2ray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/v2fly/v2ray-core";
    license = lib.licenses.mit;
  };
}
