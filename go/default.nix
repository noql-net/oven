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

  "tun2socks" = doGo121 "tun2socks";

  "age" = doGo122 "age";
  "bepass-relay" = doGo122 "bepass-relay";
  "bepass" = doGo122 "bepass";
  "brook" = doGo122 "brook";
  "chisel" = doGo122 "chisel";
  "clash" = doGo122 "clash";
  "cloak" = doGo122 "cloak";
  "daze" = doGo122 "daze";
  "dnscrypt-proxy2" = doGo122 "dnscrypt-proxy2";
  "dtlspipe" = doGo122 "dtlspipe";
  "gg" = doGo122 "gg";
  "glider" = doGo122 "glider";
  "go-shadowsocks2" = doGo122 "go-shadowsocks2";
  "gost" = doGo122 "gost";
  "headscale" = doGo122 "headscale";
  "hysteria" = doGo122 "hysteria";
  "juicity" = doGo122 "juicity";
  "lyrebird" = doGo122 "lyrebird";
  "mieru" = doGo122 "mieru";
  "mihomo" = doGo122 "mihomo";
  "mtg" = doGo122 "mtg";
  "mwgp" = doGo122 "mwgp";
  "ooniprobe-cli" = doGo122 "ooniprobe-cli";
  "outline-ss-server" = doGo122 "outline-ss-server";
  "prometheus-alertmanager" = doGo122 "prometheus-alertmanager";
  "prometheus-blackbox-exporter" = doGo122 "prometheus-blackbox-exporter";
  "shadowsocks-v2ray-plugin" = doGo122 "shadowsocks-v2ray-plugin";
  "shadowsocks-xray-plugin" = doGo122 "shadowsocks-xray-plugin";
  "sing-box" = doGo122 "sing-box";
  "trojan-go" = doGo122 "trojan-go";
  "v2ray-core" = doGo122 "v2ray-core";
  "wireproxy" = doGo122 "wireproxy";
  "wiretap" = doGo122 "wiretap";
  "xray-core" = doGo122 "xray-core";
  "xray-knife" = doGo122 "xray-knife";
}
