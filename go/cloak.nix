{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "cloak";
  version = "2.12.0";

  src = fetchFromGitHub {
    owner = "cbeuw";
    repo = "Cloak";
    rev = "v${version}";
    hash = "sha256-789UyTJmIhujsg0OlCy8GqUxgHDjzkGUi5kHD5sytwQ=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-LOXPs/3qkP3GJZZ7W4rPOfAjmvNh1mowRuQ1tlV1uC4=";

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
