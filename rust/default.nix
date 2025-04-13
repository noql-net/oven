{ lib, crane, oxalica-rust, pkgs, hostPkgs }:

let
  buildSystem = pkgs.buildPlatform.system;
  fetchFromGitHub = pkgs.fetchFromGitHub;

  stableToolchain = oxalica-rust.packages."${buildSystem}".rust.override {
    targets = [ "x86_64-unknown-linux-musl" "aarch64-unknown-linux-musl" ];
  };
  stableCraneLib = (crane.mkLib pkgs).overrideToolchain stableToolchain;
  buildPackageStable = stableCraneLib.buildPackage.override {
    mkCargoDerivation = stableCraneLib.mkCargoDerivation.override {
      stdenv = hostPkgs.pkgsStatic.buildPackages.stdenv;
    };
  };

  rustTarget = pkgs.rust.toRustTarget hostPkgs.pkgsStatic.hostPlatform;
  targetCC = with hostPkgs.pkgsStatic.stdenv; "${cc}/bin/${cc.hostPrefix}cc";

  pkg-config = pkgs.pkg-config;
  openssl = hostPkgs.pkgsStatic.openssl;
in
{
  shadowsocks-rust = (import ./shadowsocks-rust.nix) {
    inherit lib fetchFromGitHub rustTarget targetCC pkg-config openssl; buildRustPackage = buildPackageStable;
  };
  tuic = (import ./tuic.nix) {
    inherit lib fetchFromGitHub rustTarget targetCC; buildRustPackage = buildPackageStable; vendorCargoDeps = stableCraneLib.vendorCargoDeps;
  };
}
