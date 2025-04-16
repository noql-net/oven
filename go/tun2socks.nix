{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "tun2socks";
  version = "2.5.2";

  src = fetchFromGitHub {
    owner = "xjasonlyu";
    repo = "tun2socks";
    rev = "v${version}";
    hash = "sha256-siAengVJXusQ5o9cTaADeRn5eW4IoCHkMMf6Bx8iWws=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-zeiOcn33PnyoseYb0wynkn7MfGp3rHEYBStY98C6aR8=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/xjasonlyu/tun2socks/v2/internal/version.Version=v${version}"
    "-X github.com/xjasonlyu/tun2socks/v2/internal/version.GitCommit=v${version}"
  ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/xjasonlyu/tun2socks";
    license = lib.licenses.gpl3Plus;
  };
}
