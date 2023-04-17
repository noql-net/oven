{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash";
  version = "1.15.1";

  src = fetchFromGitHub {
    owner = "Dreamacro";
    repo = "clash";
    rev = "v${version}";
    sha256 = "sha256-r74OL15stW+Io8+/cTGa98TVipM2sL4LnkZXHqa7CBE=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-HS3VnQ9nkRy9OEfE1ASb3fhH/JlgUSlrVlGYNYwGmVA=";

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
