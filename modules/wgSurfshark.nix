{config, ...}: {
  sops = {
    defaultSopsFile = ./../../../personal.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    secrets = {
      "wgSurfshark" = {
        sopsFile = ./../personal.yaml;
        #mode = "0400";
      };
    };
  };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = ["192.168.200.1/24"];
      listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = config.sops.secrets."wgSurfshark".path;

      peers = [
        # For a client configuration, one peer entry for the server will suffice.

        {
          # Public key of the server (not a file path).
          publicKey = "qFuwaE8IyDbNBTNar3xAXRGaBdkTtmLh1uIGMJxTxUs=";

          # Forward all the traffic via VPN.
          #allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          allowedIPs = ["192.168.100.1/32"];

          # Set this to the server IP and port.
          endpoint = "ch-zur.prod.surfshark.com:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
