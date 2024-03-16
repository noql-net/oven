{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "chisel";
  version = "1.9.1";

  src = fetchFromGitHub {
    owner = "jpillora";
    repo = "chisel";
    rev = "v${version}";
    hash = "sha256-hZm0dVDwX6cHiN0TvAcHCWbMAf+k9CCQfC9nlV2vfN4=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-i6Fb+jSP6LzZoPTHhjQi3YbPBWY6OmsORV8ATcLrHG0=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/jpillora/chisel/share.BuildVersion=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/jpillora/chisel";
    license = lib.licenses.mit;
  };
}
