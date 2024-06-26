{ lib, pkgs, stdenv, stdenvStable, go_1_22, go_1_21, go_1_20 }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  fetchFromGitLab = pkgs.fetchFromGitLab;

  doGo122 = (name: (import ./${name}.nix) {
    inherit lib fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      inherit stdenv; go = go_1_22;
    });
  });
  doGo121 = (name: (import ./${name}.nix) {
    inherit lib fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      inherit stdenv; go = go_1_21;
    });
  });
  doGo120 = (name: (import ./${name}.nix) {
    inherit lib fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      stdenv = stdenvStable; go = go_1_20;
    });
  });
in
{
  "psiphon-tunnel-core" = doGo120 "psiphon-tunnel-core";

  "age" = doGo121 "age";
  "bepass-relay" = doGo121 "bepass-relay";
  "bepass" = doGo121 "bepass";
  "chisel" = doGo121 "chisel";
  "clash" = doGo121 "clash";
  "daze" = doGo121 "daze";
  "dive" = doGo121 "dive";
  "dnscrypt-proxy2" = doGo121 "dnscrypt-proxy2";
  "dtlspipe" = doGo121 "dtlspipe";
  "gg" = doGo121 "gg";
  "glider" = doGo121 "glider";
  "go-shadowsocks2" = doGo121 "go-shadowsocks2";
  "gost" = doGo121 "gost";
  "headscale" = doGo121 "headscale";
  "lyrebird" = doGo121 "lyrebird";
  "mtg" = doGo121 "mtg";
  "mwgp" = doGo121 "mwgp";
  "prometheus-alertmanager" = doGo121 "prometheus-alertmanager";
  "trojan-go" = doGo121 "trojan-go";
  "tun2socks" = doGo121 "tun2socks";
  "wiretap" = doGo121 "wiretap";

  "brook" = doGo122 "brook";
  "cloak" = doGo122 "cloak";
  "hysteria" = doGo122 "hysteria";
  "juicity" = doGo122 "juicity";
  "mieru" = doGo122 "mieru";
  "mihomo" = doGo122 "mihomo";
  "ooniprobe-cli" = doGo122 "ooniprobe-cli";
  "outline-ss-server" = doGo122 "outline-ss-server";
  "prometheus-blackbox-exporter" = doGo122 "prometheus-blackbox-exporter";
  "shadowsocks-v2ray-plugin" = doGo122 "shadowsocks-v2ray-plugin";
  "shadowsocks-xray-plugin" = doGo122 "shadowsocks-xray-plugin";
  "sing-box" = doGo122 "sing-box";
  "v2ray-core" = doGo122 "v2ray-core";
  "wireproxy" = doGo122 "wireproxy";
  "xray-core" = doGo122 "xray-core";
  "xray-knife" = doGo122 "xray-knife";
}
