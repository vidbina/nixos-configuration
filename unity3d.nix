{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    unity3d
  ];

  security.chromiumSuidSandbox.enable = true;
}
