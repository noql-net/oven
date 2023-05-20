{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash";
  version = "1.16.0";

  src = fetchFromGitHub {
    owner = "Dreamacro";
    repo = "clash";
    rev = "v${version}";
    hash = "sha256-y2Z4YaVKKFxZzLUOUs1PeMkWhFimAhu9nAahhX/4Xn8=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-raDqnQQtkyGsop7leH6FDCOY4Yi1u/EsBVl71r3v9l0=";

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
