{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dive";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "wagoodman";
    repo = "dive";
    rev = "v${version}";
    hash = "sha256-9REthyb+bzsb7NBXkU9XyUZJFQHHrV1cG4//lTLgTgw=";
  };

  patches = [
    # fixes: unsafe.Slice requires go1.17 or later (-lang was set to go1.16; check go.mod)
    # https://github.com/wagoodman/dive/pull/461
    ./dive.patch
  ];

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-6KIbTrkvdugsUKdFBqtPUFzs/6h2xslLFpr6S2nSBiY=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
    "-X main.commit="
    "-X main.buildTime="
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/wagoodman/dive";
    license = lib.licenses.mit;
  };
}
