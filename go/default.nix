{ lib, pkgs, stdenv, stdenvStable, go_1_23, go_1_22, go_1_21, go_1_20 }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  fetchFromGitLab = pkgs.fetchFromGitLab;

  doGo = (goPackage: stdenvArg: name: (import ./${name}.nix) {
    inherit lib fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      stdenv = stdenvArg; go = goPackage;
    });
  });
in
{
  "psiphon-tunnel-core" = doGo go_1_20 stdenvStable "psiphon-tunnel-core";

  "tun2socks" = doGo go_1_21 stdenvStable "tun2socks";

  "bepass-relay" = doGo go_1_23 stdenv "bepass-relay";
  "bepass" = doGo go_1_23 stdenv "bepass";
  "brook" = doGo go_1_23 stdenv "brook";
  "chisel" = doGo go_1_23 stdenv "chisel";
  "clash" = doGo go_1_23 stdenv "clash";
  "cloak" = doGo go_1_23 stdenv "cloak";
  "daze" = doGo go_1_23 stdenv "daze";
  "dnscrypt-proxy2" = doGo go_1_23 stdenv "dnscrypt-proxy2";
  "dtlspipe" = doGo go_1_23 stdenv "dtlspipe";
  "gg" = doGo go_1_23 stdenv "gg";
  "glider" = doGo go_1_23 stdenv "glider";
  "go-shadowsocks2" = doGo go_1_23 stdenv "go-shadowsocks2";
  "gost" = doGo go_1_23 stdenv "gost";
  "headscale" = doGo go_1_23 stdenv "headscale";
  "hysteria" = doGo go_1_23 stdenv "hysteria";
  "juicity" = doGo go_1_23 stdenv "juicity";
  "lyrebird" = doGo go_1_23 stdenv "lyrebird";
  "mieru" = doGo go_1_23 stdenv "mieru";
  "mihomo" = doGo go_1_23 stdenv "mihomo";
  "mtg" = doGo go_1_23 stdenv "mtg";
  "mwgp" = doGo go_1_23 stdenv "mwgp";
  "ooniprobe-cli" = doGo go_1_23 stdenv "ooniprobe-cli";
  "outline-ss-server" = doGo go_1_23 stdenv "outline-ss-server";
  "shadowsocks-v2ray-plugin" = doGo go_1_23 stdenv "shadowsocks-v2ray-plugin";
  "shadowsocks-xray-plugin" = doGo go_1_23 stdenv "shadowsocks-xray-plugin";
  "sing-box" = doGo go_1_23 stdenv "sing-box";
  "trojan-go" = doGo go_1_23 stdenv "trojan-go";
  "v2ray-core" = doGo go_1_23 stdenv "v2ray-core";
  "wireproxy" = doGo go_1_23 stdenv "wireproxy";
  "wiretap" = doGo go_1_23 stdenv "wiretap";
  "xray-core" = doGo go_1_23 stdenv "xray-core";
  "xray-knife" = doGo go_1_23 stdenv "xray-knife";
}
