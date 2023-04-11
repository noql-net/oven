{ lib, fetchFromGitHub, buildRustPackage, rustTarget, buildCC, targetCC, pkg-config, openssl }:

buildRustPackage rec {
  pname = "shadowsocks-rust";
  version = "1.15.3";

  src = fetchFromGitHub {
    owner = "shadowsocks";
    repo = "shadowsocks-rust";
    rev = "v${version}";
    hash = "sha256-HU+9y4btWbYrkHazOudY2j9RceieBK3BS2jgLbwcEdk=";
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
  CARGO_BUILD_RUSTFLAGS = "-C target-feature=+crt-static";
  rustTargetUpper = lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] rustTarget);
  "CARGO_TARGET_${rustTargetUpper}_LINKER" = targetCC;
  TARGET_CC = targetCC;
  HOST_CC = buildCC;

  doCheck = false;

  meta = {
    homepage = "https://github.com/shadowsocks/shadowsocks-rust";
    license = lib.licenses.mit;
  };
}
