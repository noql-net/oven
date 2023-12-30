{ lib, pkgs, targetPkgs }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  fetchFromGitLab = pkgs.fetchFromGitLab;
  stdenv = targetPkgs.pkgsStatic.stdenv;

  doGo121 = (name: (import ./${name}.nix) {
    inherit lib fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      inherit stdenv; go = targetPkgs.buildPackages.go_1_21;
    });
  });
  doGo120 = (name: (import ./${name}.nix) {
    inherit lib fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      inherit stdenv; go = targetPkgs.buildPackages.go_1_20;
    });
  });
  doGo119 = (name: (import ./${name}.nix) {
    inherit lib fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      inherit stdenv; go = targetPkgs.buildPackages.go_1_19;
    });
  });
in
{
  "psiphon-tunnel-core" = doGo119 "psiphon-tunnel-core";

  "brook" = doGo120 "brook";
  "shadowsocks-v2ray-plugin" = doGo120 "shadowsocks-v2ray-plugin";
  "v2ray-core" = doGo120 "v2ray-core";
  "wireproxy" = doGo120 "wireproxy";
  "wiretap" = doGo120 "wiretap";
  "xray-knife" = doGo120 "xray-knife";

  "age" = doGo121 "age";
  "bepass-relay" = doGo121 "bepass-relay";
  "bepass" = doGo121 "bepass";
  "chisel" = doGo121 "chisel";
  "clash-meta" = doGo121 "clash-meta";
  "clash" = doGo121 "clash";
  "cloak" = doGo121 "cloak";
  "daze" = doGo121 "daze";
  "dive" = doGo121 "dive";
  "dnscrypt-proxy2" = doGo121 "dnscrypt-proxy2";
  "dtlspipe" = doGo121 "dtlspipe";
  "gg" = doGo121 "gg";
  "glider" = doGo121 "glider";
  "go-shadowsocks2" = doGo121 "go-shadowsocks2";
  "gost" = doGo121 "gost";
  "headscale" = doGo121 "headscale";
  "hysteria" = doGo121 "hysteria";
  "juicity" = doGo121 "juicity";
  "lyrebird" = doGo121 "lyrebird";
  "mieru" = doGo121 "mieru";
  "mtg" = doGo121 "mtg";
  "mwgp" = doGo121 "mwgp";
  "ooniprobe-cli" = doGo121 "ooniprobe-cli";
  "outline-ss-server" = doGo121 "outline-ss-server";
  "prometheus-alertmanager" = doGo121 "prometheus-alertmanager";
  "prometheus-blackbox-exporter" = doGo121 "prometheus-blackbox-exporter";
  "shadowsocks-xray-plugin" = doGo121 "shadowsocks-xray-plugin";
  "sing-box" = doGo121 "sing-box";
  "trojan-go" = doGo121 "trojan-go";
  "tun2socks" = doGo121 "tun2socks";
  "xray-core" = doGo121 "xray-core";
}
