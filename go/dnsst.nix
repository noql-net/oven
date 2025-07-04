{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "dnstt";
  version = "c9c02b8";

  src = fetchFromGitHub {
    owner = "tladesignz";
    repo = "dnstt";
    rev = "c9c02b827b5d2d9f1f1d550bc57872deb5378805";
    hash = "sha256-K0Qh3jV3fORUQQj4Kim1NKqPz4Q55xzlC7t1rQwh6bE=";
  };

  vendorHash = "sha256-H9KVnVJUfHlqoTpaLAVbMd0p/E3poPOsnhMSfTTLvvw=";

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  subPackages = [ "dnstt-client" "dnstt-server" ];

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;

  meta = {
    description = "Userspace DNS tunnel with support for DoH and DoT";
    homepage = "https://github.com/tladesignz/dnstt";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
