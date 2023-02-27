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
  buildRustPackage = (crane.lib."${buildSystem}".overrideToolchain rustToolchain).buildPackage;

  rustTarget = targetPkgs.buildPackages.rust.toRustTarget targetPkgs.buildPackages.targetPlatform;
  buildCC = "${targetPkgs.buildPackages.stdenv.cc}/bin/${targetPkgs.buildPackages.stdenv.cc.nativePrefix}cc";
  targetCC = "${targetPkgs.pkgsStatic.stdenv.cc}/bin/${targetPkgs.pkgsStatic.stdenv.cc.targetPrefix}cc";

  pkg-config = pkgs.pkg-config;
  openssl = targetPkgs.pkgsStatic.openssl;
in
{
  shadowsocks-rust = (import ./shadowsocks-rust.nix) {
    inherit lib fetchFromGitHub buildRustPackage rustTarget buildCC targetCC pkg-config openssl;
  };
  gping = (import ./gping.nix) {
    inherit lib fetchFromGitHub buildRustPackage rustTarget buildCC targetCC;
  };
}
