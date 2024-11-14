{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mieru";
  version = "3.3.2";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    hash = "sha256-PLWGzIVkL7KCm/priKIobPxBoXqJdx769xqLCaPW+bA=";
  };

  CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-8wIPivchmhEZYhX9LfbmriMMRnxvtXhLjz7u+ukJPxo=";

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
