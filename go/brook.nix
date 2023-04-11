{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "brook";
  version = "20230404";

  src = fetchFromGitHub {
    owner = "txthinking";
    repo = "brook";
    rev = "v${version}";
    hash = "sha256-nh59sfOWLk4evuIxa35bWu0J6xSUIzrPv4oQHWSZInA=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-PYdR0vfgOgRheHDvoIC9jCFmfzCSOhxqcPFm+MqirsQ=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "cli/brook" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/txthinking/brook";
    license = lib.licenses.gpl3Plus;
  };
}
