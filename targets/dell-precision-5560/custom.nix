{ config, pkgs, ... }:

{
  hardware = {
    # https://nixos.wiki/wiki/OpenGL
    opengl = {
      enable = true;
    };
  };
}
