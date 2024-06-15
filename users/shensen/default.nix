{ config, pkgs, pkgs-stable, lib, home-manager, personalValues, ... }:
{

      nixpkgs.config.allowUnfree = true;

    #users.mutableUsers = false;

    sops = {
      #defaultSopsFile = ./personal.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      #age.keyFile = "/persist/sops.txt";

      secrets = {
        "github" = {
          sopsFile = ./../../personal.yaml; 
          path = "/var/secrets/ghauth";
          mode = "0440";
          owner = config.users.users.shensen.name;
          group = config.users.users.shensen.group;
        };
      };
    };


 programs.fish.shellInit = '' set -Ux GITHUB_TOKEN "$(cat ${config.sops.secrets.github.path})" '';

  programs.ssh.extraConfig = ''
    Host vps1
      HostName 95.217.153.232
      User minion

    Host vps2 
      Hostname 62.141.37.79 
      User root

    Host shensen-desktop
      HostName 10.10.0.3
    
    Host shensen-laptop
      HostName 10.10.0.4

    Host mate9
      HostName 10.10.0.5
      User admin

    Host *
      User shensen
      Compression yes
      IdentityFile /home/shensen/.ssh/ssh_shensen_ed25519_key

  '';


environment.shellAliases = {
    ue5 = "DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 steam-run /home/shensen/Programme/UE5/Engine/Binaries/Linux/UnrealEditor";
    /*
    ssh-desktop = "ssh -i ~/.ssh/ssh_shensen-desktop_ed25519_key shensen@10.100.0.2";
    ssh-laptop  = "ssh -i ~/.ssh/ssh_shensen-desktop_ed25519_key shensen@10.100.0.3";
    ssh-local   = "ssh -i ~/.ssh/ssh_shensen-desktop_ed25519_key shensen@localhost";
    */    
  };


    users.users = {
      shensen = {
        isNormalUser = true;
        home = "/home/shensen";
        hashedPassword = "$6$gyE3kfPqlLctzSG4$HtIj8ic9v8.no00Xw7TU.B6lZVgi0gW5ERewTqFvTzeHwxcC3884Bcw4d9qvxQljux08iTr0YrbYj30dHA4c41";
        extraGroups = [ "wheel" "render" "video" ];
        group = "shensen";

        openssh.authorizedKeys.keys = [
          personalValues.pubHostKey.shensen-desktop
          personalValues.pubHostKey.shensen-laptop
          personalValues.pubUserKey.shensen
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDvH0VOc+opJ6A4qIgLAcURJG7oV5mbvnmstc7sh4lVc shensen"
        ];

      };
    };
    users.groups.shensen = {};

    environment.systemPackages = 
    (with pkgs; [

      # Audio Editing
      mixxx audacity
      # Coding
      kate github-desktop git gitFull gh tk
      # Desktop
      firefox thunderbird chromium tor-browser onionshare-gui
      # Gaming
      steam lutris heroic-unwrapped gnome3.adwaita-icon-theme
      # Media
      vlc
      # Messenger
      signal-desktop telegram-desktop discord teamspeak_client element-desktop
      # Office
      pkgs.onlyoffice-bin obsidian
      # QoL
      baobab keepassxc
      # Bildbearbeitung
      imagemagick ffmpeg imagemagick_light davinci-resolve
      # Virtualisierung //
      docker wineWowPackages.stable protonup-qt

      # Java
      jdk
      
    ])
    ++ 
    (with pkgs-stable; [

      #######

    ])
    ++
    ([

      
    ]);
    
    


  


    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    users.extraGroups.vboxusers.members = [ "shensen" ];



    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    programs.partition-manager.enable = true;





/*
   systemd.user.services.ghauth = {
      enable = true;
      description = "ghauth";
      unitConfig = {
        Type = "oneshot";
      };
      serviceConfig = {
        ExecStart = "/bin/sh -c 'gh auth login --token-file /run/secrets/github' ";
      };
      wantedBy = [ "default.target" ];
    };

 # Autostart
/*

  systemd.packages = [pkgs.steam pkgs.signal-desktop];

    systemd.user.services.steam = {
      enable = true;
      description = "steam";
      unitConfig = {
        #Type = "simple";
        # ...
      };
      serviceConfig = {
        ExecStart = "/bin/sh -c '/run/current-system/sw/bin/steam' ";
        # ...
      };
      wantedBy = [ "default.target" ];
      # ...
    };

###
    systemd.user.services.signal = {
      enable = true;
      description = "signal";
      unitConfig = {
        Type = "simple";
        # ...
      };
      serviceConfig = {
        ExecStart = "/bin/sh -c '/run/current-system/sw/bin/signal-desktop' ";
        # ...
      };
      wantedBy = [ "default.target" ];
      # ...
    };

###
    systemd.user.services.KeePassXC = {
      enable = true;
      description = "KeePassXC";
      unitConfig = {
        Type = "simple";
        # ...
      };
      serviceConfig = {
        ExecStart = "/bin/sh -c '/run/current-system/sw/bin/keepassxc' ";
        # ...
      };
      wantedBy = [ "default.target" ];
      # ...
    };

###
    systemd.user.services.obsidian = {
      enable = true;
      description = "obsidian";
      unitConfig = {
        Type = "simple";
        # ...
      };
      serviceConfig = {
        ExecStart = "/bin/sh -c '/run/current-system/sw/bin/obsidian' ";
        # ...
      };
      wantedBy = [ "default.target" ];
      # ...
    };

###
    systemd.user.services.telegram-desktop = {
      enable = true;
      description = "telegram-desktop";
      unitConfig = {
        Type = "simple";
        # ...
      };
      serviceConfig = {
        ExecStart = "/bin/sh -c '/run/current-system/sw/bin/telegram-desktop' ";
        # ...
      };
      wantedBy = [ "default.target" ];
      # ...
    };
*/
}
