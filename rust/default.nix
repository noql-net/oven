{ lib, crane, fenix, pkgs, targetPkgs }:

let
  buildSystem = pkgs.buildPlatform.system;
  fetchFromGitHub = pkgs.fetchFromGitHub;

  stableToolchain = with fenix.packages."${buildSystem}"; combine [
    stable.cargo
    stable.rustc
    targets."aarch64-unknown-linux-musl".stable.rust-std
    targets."x86_64-unknown-linux-musl".stable.rust-std
  ];
  stableCraneLib = crane.lib."${buildSystem}".overrideToolchain stableToolchain;
  buildPackageStable = stableCraneLib.buildPackage.override {
    mkCargoDerivation = stableCraneLib.mkCargoDerivation.override {
      stdenv = targetPkgs.pkgsStatic.buildPackages.stdenv;
    };
  };

  nightlyToolchain = with fenix.packages."${buildSystem}"; combine [
    latest.cargo
    latest.rustc
    targets."aarch64-unknown-linux-musl".latest.rust-std
    targets."x86_64-unknown-linux-musl".latest.rust-std
  ];
  nightlyCraneLib = crane.lib."${buildSystem}".overrideToolchain nightlyToolchain;
  buildPackageNightly = nightlyCraneLib.buildPackage.override {
    mkCargoDerivation = nightlyCraneLib.mkCargoDerivation.override {
      stdenv = targetPkgs.pkgsStatic.buildPackages.stdenv;
    };
  };

  rustTarget = targetPkgs.pkgsStatic.buildPackages.rust.toRustTarget targetPkgs.pkgsStatic.buildPackages.targetPlatform;
  buildCC = "${targetPkgs.pkgsStatic.buildPackages.stdenv.cc}/bin/${targetPkgs.pkgsStatic.buildPackages.stdenv.cc.nativePrefix}cc";
  targetCC = "${targetPkgs.pkgsStatic.stdenv.cc}/bin/${targetPkgs.pkgsStatic.stdenv.cc.targetPrefix}cc";

  pkg-config = pkgs.pkg-config;
  openssl = targetPkgs.pkgsStatic.openssl;
in
{
  gping = (import ./gping.nix) {
    inherit lib fetchFromGitHub rustTarget buildCC targetCC; buildRustPackage = buildPackageStable;
  };
  shadow-tls = (import ./shadow-tls.nix) {
    inherit lib fetchFromGitHub rustTarget buildCC targetCC;  buildRustPackage = buildPackageNightly;
  };
  shadowsocks-rust = (import ./shadowsocks-rust.nix) {
    inherit lib fetchFromGitHub rustTarget buildCC targetCC pkg-config openssl; buildRustPackage = buildPackageStable;
  };
}
