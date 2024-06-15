{ config, pkgs, sops-nix, nixpkgs-unstable, ... }:

{

 

  imports =
    [
      ./modules/shell.nix
      ./modules/ssh.nix
    ];


  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";

  };

nix.settings.auto-optimise-store = true;
      nixpkgs.config.allowUnfree = true;
#nixpkgs-unstable.config.allowUnfree = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
