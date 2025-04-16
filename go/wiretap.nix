{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "wiretap";
  version = "0.4.3";

  src = "${fetchFromGitHub {
    owner = "sandialabs";
    repo = "wiretap";
    rev = "v${version}";
    hash = "sha256-4066LvIxZVLJxS1ilfdPaPsJHwrUXxTyVnkJKxvWIqs=";
  }}/src";

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-cpJ/1nJDQzMiPP+uB8vRkan1MwzIpWcJYaYQv6KB6+o=";

  ldflags = [
    "-s"
    "-w"
    "-X wiretap/cmd.Version=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/sandialabs/wiretap";
    license = lib.licenses.mit;
  };
}
