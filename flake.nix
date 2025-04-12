{
  description = "oven";
  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    crane.url = "github:ipetkov/crane/v0.20.1";
    oxalica-rust.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, crane, oxalica-rust }: {
    packages =
      let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        pkgsStable = nixpkgs-stable.legacyPackages.x86_64-linux;
      in
      {
        x86_64-linux = let
          targetPkgs = pkgs;
          targetPkgsStable = pkgsStable;
        in
          ((import ./go) {
            inherit lib pkgs;
            stdenv = targetPkgs.pkgsStatic.stdenv;
            stdenvStable = targetPkgsStable.pkgsStatic.stdenv;
            go_1_22 = targetPkgs.buildPackages.go_1_22;
            go_1_21 = targetPkgsStable.buildPackages.go_1_21;
            go_1_20 = targetPkgsStable.buildPackages.go_1_20;
          }) //
          ((import ./rust) { inherit lib crane oxalica-rust pkgs targetPkgs; });

        aarch64-linux = let
          targetPkgs = pkgs.pkgsCross.aarch64-multiplatform-musl;
          targetPkgsStable = pkgsStable.pkgsCross.aarch64-multiplatform-musl;
        in
          ((import ./go) {
            inherit lib pkgs;
            stdenv = targetPkgs.pkgsStatic.stdenv;
            stdenvStable = targetPkgsStable.pkgsStatic.stdenv;
            go_1_22 = targetPkgs.buildPackages.go_1_22;
            go_1_21 = targetPkgsStable.buildPackages.go_1_21;
            go_1_20 = targetPkgsStable.buildPackages.go_1_20;
          }) //
          ((import ./rust) { inherit lib crane oxalica-rust pkgs targetPkgs; });
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
