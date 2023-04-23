{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash";
  version = "1.15.0";

  src = fetchFromGitHub {
    owner = "Dreamacro";
    repo = "clash";
    rev = "v${version}";
    hash = "sha256-uuhxxNLhwZrOvxRRiuJ2iY5rcAA/K8KAUryA01aisSI=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-HS3VnQ9nkRy9OEfE1ASb3fhH/JlgUSlrVlGYNYwGmVA=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/Dreamacro/clash/constant.Version=${version}"
    "-X github.com/Dreamacro/clash/constant.BuildTime="
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Dreamacro/clash";
    license = lib.licenses.gpl3Plus;
  };
}
