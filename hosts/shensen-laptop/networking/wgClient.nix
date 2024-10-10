{
  softSecrets,
  config,
  ...
}: let
  domainip = softSecrets.hosts.vps1.ip;
in {
  sops = {
    defaultSopsFile = ./../../../personal.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    secrets = {
      "wgSSHLaptopPrivate" = {
      };
    };
  };

  networking.nameservers = ["10.0.0.2"];
  networking.firewall = {
    allowedUDPPorts = [51821]; # Clients and peers can use the same port, see listenport
  };

  networking.nat.enable = false;
  networking.nat.externalInterface = "wlo1";
  networking.nat.internalInterfaces = ["circle"];

  # Enable WireGuard
  networking.wireguard.interfaces = {
    circle = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = ["10.0.0.4/32"];
      listenPort = 51821; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
      mtu = 1360;

      privateKeyFile = config.sops.secrets.wgSSHLaptopPrivate.path;
      peers = [
        {
          # VPS1
          publicKey = "${softSecrets.hosts.vps1.wg.circle.key}";
          allowedIPs = ["10.0.0.0/24"];
          endpoint = "${domainip}:51821";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
