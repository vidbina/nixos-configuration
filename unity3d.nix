{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    unity3d
  ];

  security.chromiumSuidSandbox.enable = true;
}
