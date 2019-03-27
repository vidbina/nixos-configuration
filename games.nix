{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    godot
  ];
}
