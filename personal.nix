{ lib, config, ... }:


{
  options.personal = {
    pubHostKey = {
      shensen-desktop = mkOption {
        type = types.str;
        default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExJxzvuMOHVDpQOJMTQqzgwB2uYYswUcW9vne0MYdok shensen";
        description = "Public SSH host key for shensen's desktop";
      };
      shensen-laptop = mkOption {
        type = types.str;
        default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDvH0VOc+opJ6A4qIgLAcURJG7oV5mbvnmstc7sh4lVc shensen";
        description = "Public SSH host key for shensen's laptop";
      };
      Mate9 = mkOption {
        type = types.str;
        default = "";
        description = "Public SSH host key for shensen's laptop";
      };
      VPS1 = mkOption {
        type = types.str;
        default = "";
        description = "Public SSH host key for shensen's laptop";
      };

    };
    pubUserKey = {

      shensen = mkOption {
        type = types.str;
        default = "";
        description = "Public SSH user key for shensen";
        };
      };

    pubWgSshKey = {
        shensen-desktop = mkOption {
            type = types.str;
            default = "ZcQUpbJYEjzxN2wdM4/U05gRvIyF/igvjsKa7PVkQnI=";
        };
        shensen-laptop = mkOption {
            type = types.str;
            default = "cJWSkvAzwRrqLiOX3ALhvFtgPXptLA3pm3qH721eDl4=";
        };

        Mate9 = mkOption {
            type = types.str;
            default = "7rUZnuBakEBzN3N7oKjQ0BFIbY/8lUQ/tokN6MDRACQ=";
        };
        VPS1 = mkOption {
            type = types.str;
            default = "1EHqAWh3NdHlFOFnsaRh9Wr3QgTw/WXyIBrTHKd7nEs=";
        };
    };

    MAC = {
        shensen-desktop = mkOption {
            type = types.str;
            default = "9c:6b:00:1e:d8:7f";
        };
        shensen-laptop = mkOption {
            type = types.str;
            default = "f8:89:d2:a9:41:5b";
        };
    };
  };


}
