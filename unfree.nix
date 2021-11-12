{ pkgs, ... }:

{
  nixpkgs.config = with pkgs; {
    allowUnfreePredicate = (pkg: builtins.elem (lib.getName pkg) [
      "aseprite"
      "obsidian"
      "teams"
      "zoom"
    ]);
  };
}
