{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "clash";
  version = "1.18.0";

  src = fetchFromGitHub {
    owner = "Dreamacro";
    repo = "clash";
    rev = "v${version}";
    hash = "sha256-LqjSPlPkR5sB4Z1pmpdE9r66NN7pwgE9GK4r1zSFlxs=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-EWAbEFYr15RiJk9IXF6KaaX4GaSCa6E4+8rKL4/XG8Y=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/Dreamacro/clash/constant.Version=${version}"
    "-X github.com/Dreamacro/clash/constant.BuildTime="
  ];
  subPackages = [ "." ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/Dreamacro/clash";
    license = lib.licenses.gpl3Plus;
  };
}
