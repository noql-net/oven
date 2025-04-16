{ lib, buildGoModule, fetchFromGitHub, file, postInstall, ... }:

buildGoModule rec {
  inherit postInstall;
  pname = "trojan-go";
  version = "0.10.6";

  src = fetchFromGitHub {
    owner = "p4gefau1t";
    repo = "trojan-go";
    rev = "v${version}";
    hash = "sha256-ZzIEKyLhHwYEWBfi6fHlCbkEImetEaRewbsHQEduB5Y=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-c6H/8/dmCWasFKVR15U/kty4AzQAqmiL/VLKrPtH+s4=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;
  nativeBuildInputs = [ file ];

  meta = {
    homepage = "https://github.com/p4gefau1t/trojan-go";
    license = lib.licenses.gpl3Plus;
  };
}
