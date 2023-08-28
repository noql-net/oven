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

  "age" = doGo120 "age";
  "brook" = doGo120 "brook";
  "chisel" = doGo120 "chisel";
  "clash-meta" = doGo120 "clash-meta";
  "clash" = doGo120 "clash";
  "cloak" = doGo120 "cloak";
  "daze" = doGo120 "daze";
  "dive" = doGo120 "dive";
  "dnscrypt-proxy2" = doGo120 "dnscrypt-proxy2";
  "gg" = doGo120 "gg";
  "glider" = doGo120 "glider";
  "go-shadowsocks2" = doGo120 "go-shadowsocks2";
  "gost" = doGo120 "gost";
  "headscale" = doGo120 "headscale";
  "hysteria" = doGo120 "hysteria";
  "lyrebird" = doGo120 "lyrebird";
  "mieru" = doGo120 "mieru";
  "mtg" = doGo120 "mtg";
  "mwgp" = doGo120 "mwgp";
  "ooniprobe-cli" = doGo120 "ooniprobe-cli";
  "outline-ss-server" = doGo120 "outline-ss-server";
  "prometheus-alertmanager" = doGo120 "prometheus-alertmanager";
  "prometheus-blackbox-exporter" = doGo120 "prometheus-blackbox-exporter";
  "shadowsocks-v2ray-plugin" = doGo120 "shadowsocks-v2ray-plugin";
  "shadowsocks-xray-plugin" = doGo120 "shadowsocks-xray-plugin";
  "sing-box" = doGo120 "sing-box";
  "trojan-go" = doGo120 "trojan-go";
  "tun2socks" = doGo120 "tun2socks";
  "v2ray-core" = doGo120 "v2ray-core";
  "wireproxy" = doGo120 "wireproxy";
  "wiretap" = doGo120 "wiretap";
  "xray-core" = doGo120 "xray-core";

  "juicity" = doGo121 "juicity";
}
