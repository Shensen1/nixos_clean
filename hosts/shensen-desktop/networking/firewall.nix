{ config, pkgs, ... }:
{


  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];



  # Open ports in the firewall.
  networking.firewall = {
    enable = false;


    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];



    allowedTCPPorts = [
      5357 # samba / wsdd
      24800 # barrier
      
    ];
    allowedUDPPorts = [
      3702 # samba / wsdd
      51820 # wireguard

    ];
  };


#Interface-specific firewall rules can be applied like this:
  #networking.firewall.interfaces."eth0".allowedTCPPorts = [ 80 443 ];





}
