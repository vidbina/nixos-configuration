{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unity3d
  ];

  security.chromiumSuidSandbox.enable = true;
}
