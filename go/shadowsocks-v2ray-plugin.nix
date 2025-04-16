{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "shadowsocks-v2ray-plugin";
  version = "5.17.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "v2ray-plugin";
    rev = "v${version}";
    hash = "sha256-urUMjJv2YxRmIeYD1OcL4Re64oG18j7nundCsj32iuc=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-bckMcmH9ZLapoA2kFAk1ZtMyadIwoeyFUPN5CB1TvCw=";

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/teddysun/v2ray-plugin";
    license = lib.licenses.mit;
  };
}
