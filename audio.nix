{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    puredata
  ];

  hardware.bluetooth = {
    enable = true;
  };

  services.actkbd = with pkgs; {
    enable = true;
    bindings = [
      # "Mute" media key
      { keys = [ 113 ]; events = [ "key" ];       command = "${alsaUtils}/bin/amixer -q set Master toggle"; }

      # "Lower Volume" media key
      { keys = [ 114 ]; events = [ "key" "rep" ]; command = "${alsaUtils}/bin/amixer -q set Master 1- unmute"; }

      # "Raise Volume" media key
      { keys = [ 115 ]; events = [ "key" "rep" ]; command = "${alsaUtils}/bin/amixer -q set Master 1+ unmute"; }

#      # "Mic Mute" media key
#      { keys = [ 190 ]; events = [ "key" ];       command = "${pkgs.alsaUtils}/bin/amixer -q set Capture toggle"; }
    ];
  };

  sound.mediaKeys = {
    enable = true;
    volumeStep = "10";
  };
}
