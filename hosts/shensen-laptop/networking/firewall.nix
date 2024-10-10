{
  # Open ports in the firewall.
  networking.firewall = {
    enable = false;

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

    allowedTCPPorts = [
      5357 # samba / wsdd
    ];
    allowedUDPPorts = [
      3702 # samba / wsdd
      51820 # wireguard
    ];
  };

  #Interface-specific firewall rules can be applied like this:
  #networking.firewall.interfaces."eth0".allowedTCPPorts = [ 80 443 ];
}
