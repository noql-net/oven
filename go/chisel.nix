{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "chisel";
  version = "1.9.0";

  src = fetchFromGitHub {
    owner = "jpillora";
    repo = "chisel";
    rev = "v${version}";
    hash = "sha256-Rq8IBT29K3QiaYXFaARg5ak9llcNS/9laal/LrHM4zY=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-i6Fb+jSP6LzZoPTHhjQi3YbPBWY6OmsORV8ATcLrHG0=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/jpillora/chisel/share.BuildVersion=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/jpillora/chisel";
    license = lib.licenses.mit;
  };
}
