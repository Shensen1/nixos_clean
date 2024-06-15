{ config, pkgs, sops-nix, ... }:
{


  sops = {
    #defaultSopsFile = ./personal.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    #age.keyFile = "/persist/sops.txt";

    secrets = {
      "syncthing" = {
        sopsFile = ./../../../personal.yaml;
        mode = "0400";
      };
    };
  };


  environment.systemPackages = with pkgs; [
    syncthing
  ];

##################################### Wireguard

  # Enable WireGuard



  /*
networking = {
  bridges.br0.interfaces = [ "eth0s31f6" ]; # Adjust interface accordingly

  # Get bridge-ip with DHCP
  #useDHCP = false;
  #interfaces."br0".useDHCP = true;

  # Set bridge-ip static
  interfaces."br0".ipv4.addresses = [{
    address = "192.168.100.3";
    prefixLength = 24;
  }];
  #defaultGateway = "192.168.100.1";
  #nameservers = [ "192.168.100.1" ];
};
*/




}
