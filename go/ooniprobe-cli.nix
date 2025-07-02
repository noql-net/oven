{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.26.0";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-CTrjr3f7x2xtKvo/pO2BRVCl/5osI7seKY0lwSLvQhg=";
  };

  env.CGO_ENABLED = 1;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-ZQIuRZdS96mO72JyVUQ0lIost6ZgBPqRvTYpWl6grxY=";

  ldflags = [
    "-s"
    "-w"
  ];

  subPackages = [ "cmd/ooniprobe" ];
  doCheck = false;

  meta = {
    homepage = "https://github.com/ooni/probe-cli";
    license = lib.licenses.gpl3Plus;
  };
}
