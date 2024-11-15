{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.20.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-9YPFgsU1XpdT+fRaJmEB3z5sKjkrG3aiRIV3r4cDLfE=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-Z+jM02SzmpuZ3PXXqrLDIOWDhIh8AxMUr1S4A+du5LU=";

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
