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
        # lib = nixpkgs.lib;
        # pkgs = nixpkgs.legacyPackages.x86_64-linux;
        # pkgsStable = nixpkgs-stable.legacyPackages.x86_64-linux;
      in
      {
        x86_64-linux = let
          pkgs = import nixpkgs {
            localSystem = { config = "aarch64-unknown-linux-gnu"; };
            # buildPlatform = "aarch64-linux";
            crossSystem = { config = "x86_64-unknown-linux-musl"; };
          };
          lib = nixpkgs.lib;
          # hostPkgs = pkgs;
          # hostPkgsStable = pkgsStable;
        in
          ((import ./go) {
            inherit lib pkgs;
            stdenv = pkgs.stdenv;
            # stdenvStable = hostPkgsStable.pkgsStatic.stdenvNoCC;
            go_1_24 = pkgs.buildPackages.go_1_24;
            # go_1_23 = hostPkgs.buildPackages.go_1_23;
            # go_1_22 = hostPkgs.buildPackages.go_1_22;
            # go_1_21 = hostPkgsStable.buildPackages.go_1_21;
            # go_1_20 = hostPkgsStable.buildPackages.go_1_20;
          }); #//
          # ((import ./rust) { inherit lib crane oxalica-rust pkgs hostPkgs; });

        # aarch64-linux = let
        #   hostPkgs = pkgs.pkgsCross.aarch64-multiplatform-musl;
        #   hostPkgsStable = pkgsStable.pkgsCross.aarch64-multiplatform-musl;
        # in
        #   ((import ./go) {
        #     inherit lib pkgs;
        #     stdenv = hostPkgs.pkgsStatic.stdenv;
        #     stdenvStable = hostPkgsStable.pkgsStatic.stdenv;
        #     go_1_24 = hostPkgs.buildPackages.go_1_24;
        #     go_1_23 = hostPkgs.buildPackages.go_1_23;
        #     go_1_22 = hostPkgs.buildPackages.go_1_22;
        #     go_1_21 = hostPkgsStable.buildPackages.go_1_21;
        #     go_1_20 = hostPkgsStable.buildPackages.go_1_20;
        #   }) //
        #   ((import ./rust) { inherit lib crane oxalica-rust pkgs hostPkgs; });
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
