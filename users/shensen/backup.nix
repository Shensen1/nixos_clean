{
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
      "shensen-laptop" = { id = "SKYUBPX-DPQ3CMC-UP6ZFPY-XDD4CSY-PCU2MWG-NFRB66H-T3ZNJ4X-T7NWBQC"; };
      "shensen-desktop" = { id = "MP335AY-NDAHM3Y-K67T6ZK-EFJKI2F-6XZZ53J-BK7OEP2-AMTMMCM-4JC3DA2"; };
      "mate9" = { id = "RWEAYTU-MWSQZFQ-PLZMVE5-CXS47LK-723SYKE-MQVMQVH-DUPQVPL-LS7GGQ5"; };
    };

    settings.folders = {

      "keepass" = { 
        path = "/home/shensen/Keepass Databases/"; 
        devices = [ "shensen-laptop" "shensen-desktop" "mate9" ]; 
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
        devices = [ "shensen-laptop" "shensen-desktop" "mate9" ]; 
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
        devices = [ "shensen-laptop" "shensen-desktop" "mate9" ]; 
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
        devices = [ "shensen-laptop" "shensen-desktop" "mate9" ]; 
        versioning = { 
          type = "simple"; 
          params = { 
            keep = "10";
          }; 
        };
      };

      "office" = { 
        path = "/home/shensen/Documents/_Office/"; 
        devices = [ "shensen-laptop" "shensen-desktop" "mate9" ]; 
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