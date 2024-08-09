{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "xray-core";
  version = "1.8.15";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    hash = "sha256-DpL4nqMe/f0ibALoGE14oJ3ITaj3xjX3rkVqW+54Y7E=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-nMVMbZPIn/mBHgPqH026t1dgi6t/RT+jhT/KseRO1fE=";

  ldflags = [
    "-s"
    "-w"
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
