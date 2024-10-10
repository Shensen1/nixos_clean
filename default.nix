{lib, ...}: {
  imports = [
    ./ssh.nix
  ];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-substituters = ["https://ai.cachix.org"];
  nix.settings.trusted-public-keys = ["ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="];
  nix.settings.auto-optimise-store = true;

  nix = {
    # Use the new CLI and enable flakes
    # Make builds run with low priority so my system stays responsive
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    # automatically hardlink identical files
    optimise = {
      automatic = true;
      dates = ["daily"];
    };
    # automatically trigger garbage collection
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
    };
  };

  # Clean up system generations more intelligently than nix-collect-garbage
  systemd.services.system-profile-cleanup = let
    keepAtLeast = 5;
    cutoffDate = "30 days ago";
  in {
    description = "system profile cleaner";
    startAt = "daily";
    script = ''
      cutoff="$(date -d ${lib.escapeShellArg cutoffDate} '+%s')"
      prev=$(date '+%s')
      count=${toString keepAtLeast}
      for f in $(ls -1Adt --time=birth /nix/var/nix/profiles/system-*);do
        cur="$(stat -c '%W' "$f")"
        if [ "$prev" -lt "$cutoff" ] && [ "$count" -lt 1 ]; then
          part="''${f#/nix/var/nix/profiles/system-}"
          echo "Removing generation ''${part%-link}"
          rm -f -- "$f"
        fi
        prev="$cur"
        count=$(($count - 1))
      done
    '';
  };
  systemd.timers.system-profile-cleanup.timerConfig.Persistent = true;
}
