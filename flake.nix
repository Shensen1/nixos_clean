{
  description = "My shareable, all purpose NixOS standard Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs.nix-colors.url = "github:misterio77/nix-colors";

  #inputs.home-manager.url = "github:nix-community/home-manager";
  #inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.sops-nix.url = "github:Mic92/sops-nix";
  inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nixified-ai.url = "github:/nixified-ai/flake";
  inputs.nixified-ai.inputs.nixpkgs.follows = "nixpkgs";

  inputs.simple-nixos-mailserver.url = "gitlab:/simple-nixos-mailserver/nixos-mailserver/nixos-24.05";

  inputs.nix-bitcoin.url = "github:fort-nix/nix-bitcoin/release";

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-unstable,
    flake-utils,
    sops-nix,
    nixos-hardware,
    home-manager,
    simple-nixos-mailserver,
    nix-bitcoin,
    ...
  }: let
    softSecrets = import ./secrets;
    #system = "x86_64-linux";
    #lib = nixpkgs.lib;


    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    pkgs-unstable = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    pkgs-stable = import inputs.nixpkgs-stable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    #################
    #    PRIVATE
    #################

    nixosConfigurations = {
      shensen-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops
          ./default.nix
          ./hosts/shensen-desktop

          ./users/shensen/full.nix
          ./users/shensen/backup.nix
          ./hosts/shensen-desktop/networking/nfsvps1.nix

          ./modules/shell/fish.nix
          ./modules/display.nix
          ./modules/sunshine.nix
          ./modules/printermx435.nix
          ./modules/vscode.nix

          ./modules/llm-rocm.nix
          ./modules/messengerhelper

          ./container/open-webui/docker-compose.nix
          #./modules/comfyui
        ];

        specialArgs = {
          inherit
            softSecrets
            pkgs-stable
            pkgs-unstable
            ;
        };
      };

      shensen-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops
          ./default.nix
          ./hosts/shensen-laptop

          ./users/shensen/full.nix
          ./users/shensen/backup.nix

          ./modules/shell/fish.nix
          ./modules/display.nix
          ./modules/printermx435.nix
          ./modules/vscode.nix

          ./modules/llm-cpu.nix
          ./modules/messengerhelper
        ];
        specialArgs = {
          inherit
            softSecrets
            pkgs-stable
            pkgs-unstable
            ;
        };
      };

      #################
      #     VPS
      #################

      vps1 = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops
          simple-nixos-mailserver.nixosModule
          ./default.nix
          ./hosts/vps1
          ./hosts/vps1/nfs.nix
          ./users/root
          ./users/minion
          ./users/shensen

          ./modules/shell

          ./modules/llm-cpu.nix

          ./modules/landingPage
          ./modules/nextcloud29
          ./modules/mailserver
        ];
        specialArgs = {
          inherit
            softSecrets
            pkgs-stable
            pkgs-unstable
            ;
        };
      };
    };

    #################
    #     HOME
    #################
    /*
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "shensen@shensen-desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit pkgs ;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix

          #./users/shensen/home.nix
        ];
      };
    };
    */
  };
}
