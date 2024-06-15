{config, pkgs, sops-nix, personalValues, ...}:{
 sops = {
      defaultSopsFile = ./../../allHosts.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      #age.keyFile = "/persist/sops.txt";

      secrets = {
        "wgSSHVPS1Private" = {
          #path = "";
          #mode = "0440";
          #owner = config.users.users.shensen.name;
          #group = config.users.users.shensen.group;
        };
      };

    };

  
    boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  


networking.nat.enable = false;
  networking.nat.externalInterface = "eth0";
  networking.nat.internalInterfaces = [ "wgssh" ];
  networking.firewall = {
    allowedUDPPorts = [ 51821 ]; # Clients and peers can use the same port, see listenport
  };
  # Enable WireGuard
  networking.wireguard.interfaces = {
     # "wg0" is the network interface name. You can name the interface arbitrarily.
    wgssh = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.0.0.2/32" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51821;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i wgssh -j ACCEPT
        ${pkgs.iptables}/bin/iptables -A FORWARD -o wgssh -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING  -o eth0 -j MASQUERADE

      '';
        # /bin/sh sysctl net.ipv4.ip_forward=1
      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wgssh -j ACCEPT
        ${pkgs.iptables}/bin/iptables -D FORWARD -o wgssh -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING  -o eth0 -j MASQUERADE
      '';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = config.sops.secrets.wgSSHVPS1Private.path;

      peers = [
        # List of allowed peers.


        { # Desktop
          publicKey = "${personalValues.pubWgSshKey.shensen-desktop}";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.0.0.3/32" "192.168.0.0/24" ];
        } 
        { # Laptop
          publicKey = "${personalValues.pubWgSshKey.shensen-laptop}";
          allowedIPs = [ "10.0.0.4/32" ];
        }
        { # Mate9
          publicKey = "${personalValues.pubWgSshKey.mate9}";
          allowedIPs = [ "10.0.0.5/32" ];
        }
        /*
        { # VPS2
          publicKey = "${personalValues.pubWgSshKey.VPS2}";
          allowedIPs = [ "10.0.0.6/24" ];
        }
        */
      ];
    };
  };
} 