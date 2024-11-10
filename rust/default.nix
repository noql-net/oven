{ lib, crane, oxalica-rust, pkgs, targetPkgs }:

let
  buildSystem = pkgs.buildPlatform.system;
  fetchFromGitHub = pkgs.fetchFromGitHub;

  oldToolchain = oxalica-rust.packages."${buildSystem}"."rust_1_79_0".override {
    targets = [ "x86_64-unknown-linux-musl" "aarch64-unknown-linux-musl" ];
  };
  oldCraneLib = crane.lib."${buildSystem}".overrideToolchain oldToolchain;
  buildPackageOld = oldCraneLib.buildPackage.override {
    mkCargoDerivation = oldCraneLib.mkCargoDerivation.override {
      stdenv = targetPkgs.pkgsStatic.buildPackages.stdenv;
    };
  };

  stableToolchain = oxalica-rust.packages."${buildSystem}".rust.override {
    targets = [ "x86_64-unknown-linux-musl" "aarch64-unknown-linux-musl" ];
  };
  stableCraneLib = crane.lib."${buildSystem}".overrideToolchain stableToolchain;
  buildPackageStable = stableCraneLib.buildPackage.override {
    mkCargoDerivation = stableCraneLib.mkCargoDerivation.override {
      stdenv = targetPkgs.pkgsStatic.buildPackages.stdenv;
    };
  };

  nightlyToolchain = oxalica-rust.packages."${buildSystem}".rust-nightly_2023-12-17.override {
    targets = [ "x86_64-unknown-linux-musl" "aarch64-unknown-linux-musl" ];
  };
  nightlyCraneLib = crane.lib."${buildSystem}".overrideToolchain nightlyToolchain;
  buildPackageNightly = nightlyCraneLib.buildPackage.override {
    mkCargoDerivation = nightlyCraneLib.mkCargoDerivation.override {
      stdenv = targetPkgs.pkgsStatic.buildPackages.stdenv;
    };
  };

  rustTarget = pkgs.rust.toRustTarget targetPkgs.pkgsStatic.hostPlatform;
  targetCC = with targetPkgs.pkgsStatic.stdenv; "${cc}/bin/${cc.targetPrefix}cc";

  pkg-config = pkgs.pkg-config;
  openssl = targetPkgs.pkgsStatic.openssl;
in
{
  gping = (import ./gping.nix) {
    inherit lib fetchFromGitHub rustTarget targetCC; buildRustPackage = buildPackageOld;
  };
  shadow-tls = (import ./shadow-tls.nix) {
    inherit lib fetchFromGitHub rustTarget targetCC;  buildRustPackage = buildPackageNightly;
  };
  shadowsocks-rust = (import ./shadowsocks-rust.nix) {
    inherit lib fetchFromGitHub rustTarget targetCC pkg-config openssl; buildRustPackage = buildPackageStable;
  };
  tuic = (import ./tuic.nix) {
    inherit lib fetchFromGitHub rustTarget targetCC; buildRustPackage = buildPackageStable; vendorCargoDeps = stableCraneLib.vendorCargoDeps;
  };
}
