{ pkgs, ... }:

{
  nixpkgs.config = with pkgs; {
    allowUnfreePredicate = (pkg: builtins.elem (lib.getName pkg) [
      "aseprite"
      "nvidia-x11"
      "nvidia-settings"
    ]);
  };
}
