{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alsaUtils
    pamixer
    paprefs
    pavucontrol
  ];

  hardware.bluetooth = {
    enable = true;
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    # https://nixos.wiki/wiki/Bluetooth#Using_Bluetooth_headsets_with_PulseAudio
    package = pkgs.pulseaudioFull;
  };
}
