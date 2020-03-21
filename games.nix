{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    anki
    godot
    steam
    steam-run
  ];

  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  hardware.pulseaudio.support32Bit = true;
}
