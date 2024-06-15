{ config, pkgs, lib, home-manager, pkgs-stable, personalValues, ... }:
{


    users.users = {
      minion = {

        hashedPassword = "$6$wHnSHOlcdTScLyJ2$BTEqx6RVIYGeLMEqGjjt8KyYBQSIXGe06AcM1wEufJGd1FSEQV60I2GKgvNUouzVOYrlBjg2uDTfeRNH64Gpx0";
        isNormalUser = true;
        home = "/home/minion";
        extraGroups = [ "wheel" ];
        group = "minion";


        openssh.authorizedKeys.keys = [
            personalValues.pubHostKey.shensen-desktop
            personalValues.pubHostKey.shensen-laptop
            personalValues.pubUserKey.shensen

        ];
      };
    };
    users.groups.minion = {};


# tide configure --auto --style=Rainbow --prompt_colors='16 colors' --show_time='24-hour format' --rainbow_prompt_separators=Round --powerline_prompt_heads=Round --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, frame' --prompt_connection=Dotted --powerline_right_prompt_frame=No --prompt_spacing=Compact --icons='Many icons' --transient=No

     environment.systemPackages = 
    (with pkgs; [
     

    ])
    
    ++ 
    
    (with pkgs-stable; [
      
    ]);
}