{pkgs, ...}: {
  # Desktopenviroment

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.wayland.enable = true;

  /*
  environment.systemPackages = [
   ]++ (with pkgs.lib; filter isDerivation (attrValues pkgs.plasma5Packages.kdeGear));
  */
  environment.plasma5.excludePackages = with pkgs.kdePackages; [
    neochat
  ];

  # Displaymanager
  #services.xserver.displayManager.defaultSession = "plasma";
  #services.displayManager.sddm.enable = true;

  # Windowmanager

  # Configure keymap in X11
  services.xserver.xkb.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
}
#lib.attrValues (lib.filterAttrs (attrName: pkg: attrName != "itinerary" && isDerivation pkgs) pkgs.plasma5Packages.kdeGear)

