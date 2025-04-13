{ lib, crane, oxalica-rust, pkgs }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;

  stdenv = pkgs.pkgsStatic.stdenv;
  rustTarget = stdenv.hostPlatform.rust.rustcTarget;
  ccPath = "${stdenv.cc}/bin/${stdenv.cc.targetPrefix}cc";
  stableCraneLib = (
    (crane.mkLib pkgs).overrideToolchain (
      p: p.rust-bin.stable.latest.default.override {
        targets = [
          "x86_64-unknown-linux-musl"
          "aarch64-unknown-linux-musl"
        ];
      }
    )
  ).overrideScope (final: prev: {
    mkCargoDerivation = args: prev.mkCargoDerivation ({
      CARGO_BUILD_TARGET = rustTarget;
      "CARGO_TARGET_${lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] rustTarget)}_LINKER" = ccPath;
      stdenv = stdenv;
    } // args);
  });
in
{
  shadowsocks-rust = (import ./shadowsocks-rust.nix) {
    inherit lib fetchFromGitHub;
    buildRustPackage = stableCraneLib.buildPackage;
  };
  tuic = (import ./tuic.nix) {
    inherit lib fetchFromGitHub;
    buildRustPackage = stableCraneLib.buildPackage;
    vendorCargoDeps = stableCraneLib.vendorCargoDeps;
  };
}
