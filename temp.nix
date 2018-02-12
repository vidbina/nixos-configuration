{ config, pkgs, ... }:

{
  # TODO: cleanup later
  # nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
  ] ++ (with pythonPackages; [
    glances # alternative to htop for in-tree res utilisation and web view
    screenkey
  ]);
}
