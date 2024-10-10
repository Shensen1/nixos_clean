{
  ################################# Samba

  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  services.gvfs.enable = true; # make Samba searchable trough the network

  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smb-shensen-laptop
      netbios name = smb-shensen-laptop
      security = user
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';

    /*
    shares = {
        Content_HDD = {
        path = "/mnt/HDD/00 public shared";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "shensen";
        "force group" = "users";
      };

        Mounts = {
        path = "/mnt/";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "shensen";
        "force group" = "users";
      };

        Home_Shensen = {
        path = "/home/shensen/";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "shensen";
        "force group" = "users";
      };

    };
    */
  };

  /*
  ####################################################################
  #####################################################################
                !!!!!!!!!!!!!IMPORTANT!!!!!!!!!!!!!!!!
                        User  Authentication



  For a user to be authenticated on the samba server, you must add their password using


  smbpasswd -a <user> as root.


  #####################################################################
  ####################################################################


      ​￼systemd.services.smbpwwzrd = {
        enable = true;
        description = "smbpasswd ";
        ​￼unitConfig = {
          Type = "oneshot";
          # ...
        };
        ​￼serviceConfig = {
          ExecStart = "/bin/sh -c '/run/current-system/sw/bin/smbpasswd -a shensen' ";
          # ...
        };
        wantedBy = [ "multi-user.target" ];
        # ...
      };
  */
}
