{config, pkgs, ... }: 
{



    sops = {
      defaultSopsFile = ./../personal.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      #age.keyFile = "/persist/sops.txt";

      secrets = {
        "mail1" = {
        };

        "mail1pw" = {
        };

        "nextcloud1" = {
        };

        "nextcloud1pw" = {
        };

      };
    };


  environment.systemPackages = (with pkgs; [
    arion # https://docs.hercules-ci.com/arion/

  ]);

programs.ssh.forwardX11 = true;

    networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
    # Lazy IPv6 connectivity for the container
    enableIPv6 = true;
    };


    containers.nextcloud = {





    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.100.0.100";
    localAddress = "192.168.100.11";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";
    config = { config, pkgs, lib, ... }: {

        imports = [
          ./../default.nix
        ];




        services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud28;
        hostName = "nextcloud-container";
        config.adminpassFile = config.sops.secrets.nextloud1.path; 

          extraOptions.enabledPreviewProviders = [
            "OC\\Preview\\BMP"
            "OC\\Preview\\GIF"
            "OC\\Preview\\JPEG"
            "OC\\Preview\\Krita"
            "OC\\Preview\\MarkDown"
            "OC\\Preview\\MP3"
            "OC\\Preview\\OpenDocument"
            "OC\\Preview\\PNG"
            "OC\\Preview\\TXT"
            "OC\\Preview\\XBitmap"
            "OC\\Preview\\HEIC"
          ];
        };

        system.stateVersion = "23.11";

        networking = {
        firewall = {
            enable = true;
            allowedTCPPorts = [ 80 ];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
        };
        
        services.resolved.enable = true;
    };
 };
}