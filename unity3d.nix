{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender
    unity3d
  ];

  security.chromiumSuidSandbox.enable = true;
}
