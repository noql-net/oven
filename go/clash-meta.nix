{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash-meta";
  version = "1.14.2";

  src = fetchFromGitHub {
    owner = "MetaCubeX";
    repo = "Clash.Meta";
    rev = "v${version}";
    sha256 = "sha256-sn+0TNXCK4af4zfkf09hLsFkuvkcyjhwh35kKo993FQ=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-3j+5fF57eu7JJd3rnrWYwuWDivycUkUTTzptYaK3G/Q=";

  tags = [
    "with_gvisor"
    # "with_lwip"
  ];

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/Dreamacro/clash/constant.Version=${version}"
    "-X github.com/Dreamacro/clash/constant.BuildTime="
  ];
  subPackages = [ "." ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/clash $out/bin/clash-meta
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/MetaCubeX/Clash.Meta";
    license = lib.licenses.gpl3Plus;
  };
}
