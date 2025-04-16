{
  description = "oven";
  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    crane.url = "github:ipetkov/crane/v0.20.1";
    oxalica-rust.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, crane, oxalica-rust }: {
    packages = {
      x86_64-linux = let
        pkgs = import nixpkgs {
          localSystem = { config = "x86_64-unknown-linux-gnu"; };
          crossSystem = { config = "x86_64-unknown-linux-musl"; };
          overlays = [ (import oxalica-rust) ];
        };
        pkgsStable = import nixpkgs-stable {
          localSystem = { config = "x86_64-unknown-linux-gnu"; };
          crossSystem = { config = "x86_64-unknown-linux-musl"; };
          overlays = [ (import oxalica-rust) ];
        };
        lib = nixpkgs.lib;
        postInstallScript = (import ./postInstallScript.nix) {stdenv = pkgs.stdenvNoCC; };
      in
        ((import ./go) {
          inherit lib pkgs postInstallScript;
          stdenv = pkgs.stdenvNoCC;
          stdenvStable = pkgsStable.pkgsStatic.stdenvNoCC;
          go_1_24 = pkgs.buildPackages.go_1_24;
          go_1_23 = pkgs.buildPackages.go_1_23;
          go_1_22 = pkgs.buildPackages.go_1_22;
          go_1_21 = pkgsStable.buildPackages.go_1_21;
          go_1_20 = pkgsStable.buildPackages.go_1_20;
        }) //
        ((import ./rust) { inherit lib crane oxalica-rust pkgs postInstallScript; });

      aarch64-linux = let
        pkgs = import nixpkgs {
          localSystem = { config = "x86_64-unknown-linux-gnu"; };
          crossSystem = { config = "aarch64-unknown-linux-musl"; };
          overlays = [ (import oxalica-rust) ];
        };
        pkgsStable = import nixpkgs-stable {
          localSystem = { config = "x86_64-unknown-linux-gnu"; };
          crossSystem = { config = "aarch64-unknown-linux-musl"; };
          overlays = [ (import oxalica-rust) ];
        };
        lib = nixpkgs.lib;
        postInstallScript = (import ./postInstallScript.nix) {stdenv = pkgs.stdenvNoCC; };
      in
        ((import ./go) {
          inherit lib pkgs postInstallScript;
          stdenv = pkgs.stdenvNoCC;
          stdenvStable = pkgsStable.pkgsStatic.stdenvNoCC;
          go_1_24 = pkgs.buildPackages.go_1_24;
          go_1_23 = pkgs.buildPackages.go_1_23;
          go_1_22 = pkgs.buildPackages.go_1_22;
          go_1_21 = pkgsStable.buildPackages.go_1_21;
          go_1_20 = pkgsStable.buildPackages.go_1_20;
        }) //
        ((import ./rust) { inherit lib crane oxalica-rust pkgs postInstallScript; });
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
      "https://cache.garnix.io/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
}
