{
  description = "oven";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fenix, crane }: {
    packages =
      let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      {
        x86_64-linux = let targetPkgs = pkgs.pkgsStatic; in
          ((import ./go) { inherit lib pkgs targetPkgs; }) //
          ((import ./rust) { inherit lib crane fenix pkgs targetPkgs; });

        aarch64-linux = let targetPkgs = pkgs.pkgsCross.aarch64-multiplatform-musl; in
          ((import ./go) { inherit lib pkgs targetPkgs; }) //
          ((import ./rust) { inherit lib crane fenix pkgs targetPkgs; });
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
