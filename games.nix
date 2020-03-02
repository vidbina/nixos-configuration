{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    anki
    godot
  ];
}
