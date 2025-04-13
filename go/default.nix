{ lib, pkgs, stdenv, stdenvStable, go_1_24, go_1_23, go_1_22, go_1_21, go_1_20 }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  fetchFromGitLab = pkgs.fetchFromGitLab;
  file = pkgs.file;

  doGo = (goPackage: stdenvArg: name: (import ./${name}.nix) {
    inherit lib file fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      stdenv = stdenvArg; go = goPackage;
    });
  });
in
{
  "psiphon-tunnel-core" = doGo go_1_20 stdenvStable "psiphon-tunnel-core";

  "tun2socks" = doGo go_1_21 stdenvStable "tun2socks";

  "bepass-relay" = doGo go_1_24 stdenv "bepass-relay";
  "bepass" = doGo go_1_24 stdenv "bepass";
  "brook" = doGo go_1_24 stdenv "brook";
  "chisel" = doGo go_1_24 stdenv "chisel";
  "clash" = doGo go_1_24 stdenv "clash";
  "cloak" = doGo go_1_24 stdenv "cloak";
  "daze" = doGo go_1_24 stdenv "daze";
  "dnscrypt-proxy2" = doGo go_1_24 stdenv "dnscrypt-proxy2";
  "dtlspipe" = doGo go_1_24 stdenv "dtlspipe";
  "gg" = doGo go_1_24 stdenv "gg";
  "glider" = doGo go_1_24 stdenv "glider";
  "go-shadowsocks2" = doGo go_1_24 stdenv "go-shadowsocks2";
  "gost" = doGo go_1_24 stdenv "gost";
  "headscale" = doGo go_1_24 stdenv "headscale";
  "hysteria" = doGo go_1_24 stdenv "hysteria";
  "juicity" = doGo go_1_24 stdenv "juicity";
  "lyrebird" = doGo go_1_24 stdenv "lyrebird";
  "mieru" = doGo go_1_24 stdenv "mieru";
  "mihomo" = doGo go_1_24 stdenv "mihomo";
  "mtg" = doGo go_1_24 stdenv "mtg";
  "mwgp" = doGo go_1_24 stdenv "mwgp";
  "ooniprobe-cli" = doGo go_1_24 stdenv "ooniprobe-cli";
  "outline-ss-server" = doGo go_1_24 stdenv "outline-ss-server";
  "shadowsocks-v2ray-plugin" = doGo go_1_24 stdenv "shadowsocks-v2ray-plugin";
  "shadowsocks-xray-plugin" = doGo go_1_24 stdenv "shadowsocks-xray-plugin";
  "sing-box" = doGo go_1_24 stdenv "sing-box";
  "trojan-go" = doGo go_1_24 stdenv "trojan-go";
  "v2ray-core" = doGo go_1_24 stdenv "v2ray-core";
  "wireproxy" = doGo go_1_24 stdenv "wireproxy";
  "wiretap" = doGo go_1_24 stdenv "wiretap";
  "xray-core" = doGo go_1_24 stdenv "xray-core";
  "xray-knife" = doGo go_1_24 stdenv "xray-knife";
}
