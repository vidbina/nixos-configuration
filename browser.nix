{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    (pkgs.torbrowser.override {
      extraPrefs = ''
        lockPref("browser.tabs.remote.autostart", false);
        lockPref("browser.tabs.remote.autostart.2", false);
      '';
    })
  ];
}
