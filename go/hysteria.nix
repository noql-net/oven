{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "hysteria";
  version = "2.4.3";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "app/v${version}";
    hash = "sha256-4i3bXtg7WCSPDE7fUWVJnOOFNGLAo1F/a2wbuUH785o=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  env.GOWORK = "off";
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-W3dLSyLYtwJ8As6U6oVLI5MQmO6MOx+CwiWKHIVFMmc=";

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

  meta = {
    homepage = "https://github.com/apernet/hysteria";
    license = lib.licenses.mit;
  };
}
