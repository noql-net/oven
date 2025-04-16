{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "hysteria";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-EdqFushE/G0kWOkks7m2nSQ9wXq1p1HjebSgb5tAzmo=";
  };

  sourceRoot = "source/app";

  env.CGO_ENABLED = 0;
  env.GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-IRdC+imF4MwER9ZSH5vQnm3hu7jqNw5Pfi62JU6Y9l8=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/apernet/hysteria/app/cmd.appVersion=${version}"
    "-X github.com/apernet/hysteria/app/cmd.appType=release"
  ];
  subPackages = [ "." ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/app $out/bin/hysteria
  '';

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/apernet/hysteria";
    license = lib.licenses.mit;
  };
}
