{ config, pkgs, lib, ... }:

{
  # ...
  containers.graphicalExample = let
    hostCfg = config;
    userName = "myuser";
    userUid = hostCfg.users.users."${userName}".uid;
  in {
    # (1)
    bindMounts = {
      waylandDisplay = rec {
        hostPath = "/run/user/${toString userUid}";
        mountPoint = hostPath;
      };
      x11Display = rec {
        hostPath = "/tmp/.X11-unix";
        mountPoint = hostPath;
        isReadOnly = true;
      };
    };

    config = {
      # ...
      
      # (2)
      hardware.opengl = {
        enable = true;
        extraPackages = hostCfg.hardware.opengl.extraPackages;
      };

      # (3)
      environment.systemPackages = with pkgs; [
        vim
        jetbrains.idea-community
      ];

      home-manager = {
        useGlobalPkgs = true;
        users.myuser = {
          imports = [ ./home.nix ];

          # (4)
          home.sessionVariables = {
            WAYLAND_DISPLAY                     = "wayland-1";
            QT_QPA_PLATFORM                     = "wayland";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            SDL_VIDEODRIVER                     = "wayland";
            CLUTTER_BACKEND                     = "wayland";
            MOZ_ENABLE_WAYLAND                  = "1";
            _JAVA_AWT_WM_NONREPARENTING         = "1";
            _JAVA_OPTIONS                       = "-Dawt.useSystemAAFontSettings=lcd";
            XDG_RUNTIME_DIR                     = "/run/user/${toString userUid}";
            DISPLAY                             = ":0";
          };
        };
      };
    };
  };
}