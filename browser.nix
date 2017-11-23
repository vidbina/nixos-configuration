{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    firefox
    httpie
    (pkgs.torbrowser.override {
      extraPrefs = ''
        lockPref("browser.tabs.remote.autostart", false);
        lockPref("browser.tabs.remote.autostart.2", false);
      '';
    })
    rainbowstream
  ];
}
