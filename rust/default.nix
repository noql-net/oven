{ lib, crane, fenix, pkgs, targetPkgs }:

let
  buildSystem = pkgs.buildPlatform.system;
  fetchFromGitHub = pkgs.fetchFromGitHub;

  rustToolchain = with fenix.packages."${buildSystem}"; combine [
    stable.cargo
    stable.rustc
    targets."aarch64-unknown-linux-musl".stable.rust-std
    targets."x86_64-unknown-linux-musl".stable.rust-std
  ];
  craneLib = crane.lib."${buildSystem}".overrideToolchain rustToolchain;
  buildRustPackage = craneLib.buildPackage.override {
    mkCargoDerivation = craneLib.mkCargoDerivation.override {
      stdenv = targetPkgs.buildPackages.stdenv;
    };
  };

  rustTarget = targetPkgs.buildPackages.rust.toRustTarget targetPkgs.buildPackages.targetPlatform;
  buildCC = "${targetPkgs.buildPackages.stdenv.cc}/bin/${targetPkgs.buildPackages.stdenv.cc.nativePrefix}cc";
  targetCC = "${targetPkgs.pkgsStatic.stdenv.cc}/bin/${targetPkgs.pkgsStatic.stdenv.cc.targetPrefix}cc";

  pkg-config = pkgs.pkg-config;
  openssl = targetPkgs.pkgsStatic.openssl;
in
{
  gping = (import ./gping.nix) {
    inherit lib fetchFromGitHub buildRustPackage rustTarget buildCC targetCC;
  };
  shadowsocks-rust = (import ./shadowsocks-rust.nix) {
    inherit lib fetchFromGitHub buildRustPackage rustTarget buildCC targetCC pkg-config openssl;
  };
}
