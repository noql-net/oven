# oven

The noql oven is a nix flake that acts as a builder for a small
collection of software.

The oven primarly intends to statically link and cross-compile as much
as possible, as binaries produced will be distributed to many platforms
and distributions.

If a software package is to be distributed by noql (through
repositories) then the build definition must be placed here and it must
successfully build in the oven.

# NixOS users
The oven can also be used as a flake for using the included packages on
NixOS. Just add this GitHub repo as an input to your NixOS configuration
flake and access the packages within the `packages` attribute.
