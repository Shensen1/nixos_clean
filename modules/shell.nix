{ config, pkgs, ... }:
{


  programs.bash = {
    interactiveShellInit = ''

      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
  

    '';
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
    promptInit = ''
    tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Darkest --show_time='24-hour format' --classic_prompt_separators=Angled --powerline_prompt_heads=Slanted --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Many icons' --transient=Yes' 
    ${pkgs.fish}/bin/fish zoxide init fish | source
  ''; 
  };

 

  environment.systemPackages = with pkgs; [
    pkgs.fishPlugins.tide
    pkgs.babelfish
  ##########################
    # encryption
    age
    # Editors
    vim nano
    # System Essentials
    wget
    lm_sensors
    nixos-option
    rar
    unrar
    inetutils
    tldr
    rclone
    htop
    gtop
    glances

    killall
    mkpasswd
    tmux
    unzip
    lshw
    pciutils
    ranger
    nix-prefetch-github
    jq jc jo gron yj yq pup # json/toml/yaml/hcl/xml/html handling
    bc # also includes dc
    magic-wormhole
    moreutils # sponge & more
    man-pages # linux kernel apis and other development man pages
    faketty

    # mail
    mutt neomutt

    zoxide # besseres cd
    sshfs
    sops
    ripgrep
  ];

  programs.mtr.enable = true;




#/*  Keine Ahnung warum dieser SystemD-Eintrag einen Fehler ausspuckt...
    systemd.user.services.tideconfigure = {
      enable = true;
      description = "tideconfigure";
      unitConfig = {
        Type = "oneshot";
        # ...
      };
      serviceConfig = {
        ExecStart = "/bin/sh -c '/run/current-system/sw/bin/fish tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Darkest --show_time='24-hour format' --classic_prompt_separators=Angled --powerline_prompt_heads=Slanted --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Many icons' --transient=Yes' ";
        # ...
      };
      wantedBy = [ "multi-user.target" ];
      # ...
    };





  fonts.packages = builtins.attrValues {
    nerdfonts = pkgs.nerdfonts.override { fonts = [ "DejaVuSansMono" ]; };
  };


    boot.binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };



}
