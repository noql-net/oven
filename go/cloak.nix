{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "cloak";
  version = "2.9.0";

  src = fetchFromGitHub {
    owner = "cbeuw";
    repo = "Cloak";
    rev = "v${version}";
    hash = "sha256-IclSnSJAUSWWAk8UZbUJLMVcnoZk5Yvsd1n3u67cM2g=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-kkb/gPnDbJvfc5Qqc5HuM1c9OwOu1ijfO7nNNnY3mOo=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/ck-client " "cmd/ck-server" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/cbeuw/Cloak";
    license = lib.licenses.gpl3Plus;
  };
}
