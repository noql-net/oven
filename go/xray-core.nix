{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "xray-core";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    sha256 = "sha256-YonO856ax0RTkM3SwgsS/1HxijkaV5XUXvWYDL3NyvM=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-lWeYuyzW8bR51LrFguOxOyNzihMuFF6MkFeGuNv8Vyc=";

  ldflags = [ "-s" "-w" "-buildid=" ];
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
