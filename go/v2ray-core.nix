{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.15.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-XxmzJfZa05Kf32Lh6FapYpQZProJyzlXoXKnDPiWqMQ=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-SQ7DcrKYf4Wclp/HG8e7q5YPvVNj/kHV/pGmEyOU/BY=";

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
