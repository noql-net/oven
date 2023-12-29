{ lib, fetchFromGitHub, buildRustPackage, rustTarget, targetCC, pkg-config, openssl }:

buildRustPackage rec {
  pname = "shadowsocks-rust";
  version = "1.17.1";

  src = fetchFromGitHub {
    owner = "shadowsocks";
    repo = "shadowsocks-rust";
    rev = "v${version}";
    hash = "sha256-2Y/tdO6vk7zE0mm9p7dL/Uq1qj/yLuelIRFMt2hxO6M=";
  };

  buildFeatures = [
    "stream-cipher"
    "aead-cipher-extra"
    "aead-cipher-2022"
    "local-dns"
    "local-http-native-tls"
    "local-redir"
    "local-tun"
  ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  OPENSSL_STATIC = "yes";
  OPENSSL_NO_VENDOR = 1;

  CARGO_BUILD_TARGET = rustTarget;
  "CARGO_TARGET_${lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] rustTarget)}_LINKER" = targetCC;
  TARGET_CC = targetCC;

  doCheck = false;

  meta = {
    homepage = "https://github.com/shadowsocks/shadowsocks-rust";
    license = lib.licenses.mit;
  };
}
