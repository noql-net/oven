{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.28.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-W/T6vJBkJEjbG6DcBLrtDbFgw7PNGA6RgmIY/tpJCAU=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-XKpkFWFpfykHX0XgYFtXD1nA66o1jVfjOvHrHpQYNQE=";

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
