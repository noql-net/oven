{ lib, pkgs, targetPkgs }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  fetchFromGitLab = pkgs.fetchFromGitLab;
  stdenv = targetPkgs.pkgsStatic.stdenv;

  doGo122 = (name: (import ./${name}.nix) {
    inherit lib fetchFromGitHub fetchFromGitLab;
    buildGoModule = (pkgs.buildGoModule.override {
      inherit stdenv; go = targetPkgs.buildPackages.go_1_22;
    });
  });
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
  "hysteria" = doGo121 "hysteria";
  "juicity" = doGo121 "juicity";
  "lyrebird" = doGo121 "lyrebird";
  "mieru" = doGo121 "mieru";
  "mihomo" = doGo121 "mihomo";
  "mtg" = doGo121 "mtg";
  "mwgp" = doGo121 "mwgp";
  "ooniprobe-cli" = doGo121 "ooniprobe-cli";
  "outline-ss-server" = doGo121 "outline-ss-server";
  "prometheus-alertmanager" = doGo121 "prometheus-alertmanager";
  "prometheus-blackbox-exporter" = doGo121 "prometheus-blackbox-exporter";
  "sing-box" = doGo121 "sing-box";
  "trojan-go" = doGo121 "trojan-go";
  "tun2socks" = doGo121 "tun2socks";
  "v2ray-core" = doGo121 "v2ray-core";
  "wireproxy" = doGo121 "wireproxy";
  "wiretap" = doGo121 "wiretap";
  "xray-knife" = doGo121 "xray-knife";

  "brook" = doGo122 "brook";
  "cloak" = doGo122 "cloak";
  "shadowsocks-v2ray-plugin" = doGo122 "shadowsocks-v2ray-plugin";
  "shadowsocks-xray-plugin" = doGo122 "shadowsocks-xray-plugin";
  "xray-core" = doGo122 "xray-core";
}
