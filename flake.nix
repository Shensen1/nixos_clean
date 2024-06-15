{
  description = "NixOS standard Flake";

  
    
      inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
      inputs.flake-utils.url = "github:numtide/flake-utils";
    #nixos-hardware.url = github:NixOS/nixos-hardware/master;

      inputs.home-manager.url = "github:nix-community/home-manager";
      inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
        
      inputs.sops-nix.url = "github:Mic92/sops-nix";
      inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    
      inputs.plasma-manager = {
        url = "github:pjones/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
      };

      inputs.compose2nix.url = "github:aksiksi/compose2nix";
      inputs.compose2nix.inputs.nixpkgs.follows = "nixpkgs";
    # bekomm es nicht geladen wie im repo steht.. auskommentiert in shensen



  outputs = inputs@{
    self, 
    nixpkgs, 
    nixpkgs-stable, 
    flake-utils,
    sops-nix, 
    nixos-hardware, 
    home-manager, 
    plasma-manager,
    compose2nix,
     ...}:
  
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    #pkgs-unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
    pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; config.allowUnfree = true; };




    personalValues = {
      username = "shensen";

      pubHostKey = {
        shensen-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExJxzvuMOHVDpQOJMTQqzgwB2uYYswUcW9vne0MYdok shensen";
        shensen-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDvH0VOc+opJ6A4qIgLAcURJG7oV5mbvnmstc7sh4lVc shensen";
        mate9 = "";
        vps1 = "";
        vps2 = "";
      };

      pubUserKey = {
        shensen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJAkeS/nrp7WrQ2HMrVkO0YxTi0uPPw8Mv1IyF5SJbW shensen";
      };

      pubWgSshKey = {
        shensen-desktop = "ZcQUpbJYEjzxN2wdM4/U05gRvIyF/igvjsKa7PVkQnI=";
        shensen-laptop = "cJWSkvAzwRrqLiOX3ALhvFtgPXptLA3pm3qH721eDl4=";
        mate9 = "7rUZnuBakEBzN3N7oKjQ0BFIbY/8lUQ/tokN6MDRACQ=";
        vps1 = "F9fMuRo3VsyHtZg2bnae+RPCGhEDNd0A3G7Bc9dKaDE=";
        vps2 = "";

      };

      MAC = {
        shensen-desktop = "9c:6b:00:1e:d8:7f";
        shensen-laptop = "f8:89:d2:a9:41:5b";
      };
    };

    username = personalValues.username;
  in
  {

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
          ./users/shensen
          ./users/shensen/backup.nix

          ./modules     
          ./modules/llm-rocm.nix
          ./modules/messengerhelper
          
          ./container/open-webui/open-webui.nix
          ./container/stable-diffusion-webui


        ];

        specialArgs = {
          inherit 
          personalValues
          username;
          #pubHostKey = personalValues.pubHostKey;

          
        };
      };


      shensen-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops             
          ./hosts/shensen-laptop/default.nix
          ./default.nix
          ./users/shensen
          ./users/shensen/backup.nix         
          ./modules
          #./modules/poetry2nix/flake.nix     
          ./modules/llm-cpu.nix
          ./modules/messengerhelper
          #./modules/comfyui
        ]; 
        specialArgs = {
          inherit personalValues;
        };
      };


#################
#     VPS
#################

      vps1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops  
          ./default.nix

          ./hosts/VPS1
          ./users/root
          ./users/minion

          ./modules/llm-cpu.nix
        ];
        specialArgs = {
          inherit personalValues;
        };
      };


    };

#################
#     HOME
#################

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
     homeConfigurations = {
        "shensen@shensen-desktop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit pkgs personalValues;};
          modules = [ 
            # > Our main home-manager configuration file <
            ./home-manager/home.nix
            
            #./users/shensen/home.nix 
          ];          
        };
      };


  };
}
