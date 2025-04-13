{ lib, fetchFromGitHub, buildRustPackage }:

buildRustPackage rec {
  pname = "shadowsocks-rust";
  version = "1.21.2";

  src = fetchFromGitHub {
    owner = "shadowsocks";
    repo = "shadowsocks-rust";
    rev = "v${version}";
    hash = "sha256-bvYp25EPKtkuZzplVYK4Cwd0mm4UuyN1LMiDAkgMIAc=";
  };

  buildFeatures = [ "full-extra" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/shadowsocks/shadowsocks-rust";
    license = lib.licenses.mit;
  };
}
