{ config, pkgs, ... }:

{
  hardware = {
    # https://nixos.wiki/wiki/OpenGL
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        mesa.drivers
      ];
    };
  };
}
