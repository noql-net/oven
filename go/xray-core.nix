{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "xray-core";
  version = "1.8.3";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    hash = "sha256-j7lIRGO+hUYAM/FWCb8cNoh6lXXE0ZboWA/Hmi9w/Bc=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-sBbidDvsYvFg3EqsA59MYZULim/LbrZcInixiKfwqqQ=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/xray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/XTLS/Xray-core";
    license = lib.licenses.mpl20;
  };
}
