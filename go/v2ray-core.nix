{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.5.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-Lh8FbB6QRkuD/mxjVeJ7SzGj7LSONdmSvs+uqNhYODw=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-M8wf1ZihngrJt+Asg9SoRT0M5CtFf/ihY5HqtoUXbNI=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
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
