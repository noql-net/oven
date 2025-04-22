{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "wireproxy";
  version = "1.0.10";

  src = fetchFromGitHub {
    owner = "octeep";
    repo = "wireproxy";
    rev = "v${version}";
    hash = "sha256-F8WatQsXgq3ex2uAy8eoS2DkG7uClNwZ74eG/mJN83o=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-uCU5WLCKl5T4I1OccVl7WU0GM/t4RyAEmzHkJ22py30=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/wireproxy" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/octeep/wireproxy";
    license = lib.licenses.isc;
  };
}
