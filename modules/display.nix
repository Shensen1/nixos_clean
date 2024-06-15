{ config, pkgs, ... }:
{


# Desktopenviroment

   networking.firewall = {
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };


 services.xserver.desktopManager.plasma5.enable = true;
 environment.systemPackages = [
  ]++ (with pkgs.lib; filter isDerivation (attrValues pkgs.plasma5Packages.kdeGear));




# Displaymanager

      services.displayManager.sddm.enable = true;



# Windowmanager

    # Configure keymap in X11
    services.xserver.xkb.layout = "de";
    # services.xserver.xkbOptions = "eurosign:e,caps:escape";

    # Enable the X11 windowing system.
    services.xserver.enable = true;

}
