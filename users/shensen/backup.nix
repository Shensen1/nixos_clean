{softSecrets, ...}: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/shensen";
    openDefaultPorts = true;
    configDir = "/home/shensen/.config/syncthing";
    user = "shensen";
    group = "users";
    guiAddress = "127.0.0.1:8384";
    overrideDevices = true;
    overrideFolders = true;

    settings.devices = {
      "shensen-laptop" = {id = softSecrets.hosts.shensen-laptop.syncthing.id;};
      "shensen-desktop" = {id = softSecrets.hosts.shensen-desktop.syncthing.id;};
      "mate9" = {id = softSecrets.hosts.mate9.syncthing.id;};
    };

    settings.folders = {
      "keepass" = {
        path = "/home/shensen/Keepass Databases/";
        devices = ["shensen-laptop" "shensen-desktop" "mate9"];
        versioning = {
          type = "staggered";
          params = {
            cleanInterval = "3600";
            maxAge = "15768000";
          };
        };
      };

      "kamera" = {
        id = "mha-l29_u3pp-Bilder";
        path = "/home/shensen/Pictures/Mate9/";
        devices = ["shensen-laptop" "shensen-desktop" "mate9"];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
          };
        };
      };

      "obsidian" = {
        #id = "mha-l29_u3pp-Bilder";
        path = "/home/shensen/Obsidian/";
        devices = ["shensen-laptop" "shensen-desktop" "mate9"];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
          };
        };
      };

      "documents" = {
        #id = "mha-l29_u3pp-Bilder";
        path = "/home/shensen/Documents/";
        devices = ["shensen-laptop" "shensen-desktop" "mate9"];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
          };
        };
      };

      "office" = {
        path = "/home/shensen/Documents/_Office/";
        devices = ["shensen-laptop" "shensen-desktop" "mate9"];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
          };
        };
      };
    };
  };
}
