{ config, pkgs, ... }:

# https://github.com/NixOS/nixpkgs/commit/192e0c714164a2e537ba3566306c24d9ff888ace#commitcomment-20877324
# use steam-run for standalone games
{
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [
    steam
  ];
}
