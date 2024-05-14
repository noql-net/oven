{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mieru";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    hash = "sha256-5KmsCr9N+L8v2e85Hpj4KVgHJz+UUUN0dKUDHJ0XAS4=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-EHrEJdWBmTxYtYEUvHLqRqzuSy5JRg23VT3h2lH295A=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/mieru" "cmd/mita" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/enfein/mieru";
    license = lib.licenses.mit;
  };
}
