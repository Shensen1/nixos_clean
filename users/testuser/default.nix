{ config, pkgs, personalValues, ... }:{
 users.users = {
      testuser4 = {
        isNormalUser = true;
        #home = "/home/testuser";

        #hashedPasswordFile 

        hashedPassword = "$6$OmzkjPl./P0kPqkx$9SC35uHpr2pybKQ0.PqOfpi5UV0dQXK1eBnCqfgZ44piJLZYoW.XUTn2AD7mg4DuANjB0guItF626wfaXfAS9.";
        extraGroups = ["wheel"];
        group = "testuser";

        openssh.authorizedKeys.keys = [
          personalValues.pubHostKey.shensen-desktop
          personalValues.pubHostKey.shensen-laptop
          personalValues.pubUserKey.shensen
        ];

      };
      
    };
users.groups.testuser = {};
} 
