{config, pkgs, sops-nix, personalValues, ...}:
let
  # Assuming personalValues is defined somewhere in your configuration
  publicKey = personalValues.pubWgSshKey.shensen-desktop;
  MAC1 = personalValues.MAC.shensen-desktop;
  MAC2 = personalValues.MAC.shensen-laptop;
in
{

  sops = {
      defaultSopsFile = ./../../../personal.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "wgSSHDekstopPrivate" = {
        };
      };

    };

  networking.firewall = {
    allowedUDPPorts = [ 51821 ]; # Clients and peers can use the same port, see listenport
  };


  networking.nat.enable = false;
  networking.nat.externalInterface = "enp16s0";
  networking.nat.internalInterfaces = [ "wgssh" ];


  # Enable WireGuard
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wgssh = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "10.0.0.3/32" ];
      listenPort = 51821; # to match firewall allowedUDPPorts (without this wg uses random port numbers)





      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = config.sops.secrets.wgSSHDekstopPrivate.path;
      peers = [
        # For a client configuration, one peer entry for the server will suffice.
  
        {# VPS1
          # Public key of the server (not a file path).
          publicKey = "${personalValues.pubWgSshKey.vps1}";
          allowedIPs = [  "10.0.0.2/32" "10.0.0.4/32" "10.100.0.5/32" "192.168.0.0/24"];
          endpoint = "95.217.153.232:51821";
          persistentKeepalive = 25;
        }
       
        
      ];
    };
  };

}