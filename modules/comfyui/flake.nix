{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            python311
            python311Packages.accelerate
            python311Packages.torchWithRocm
            python311Packages.torchsde
            python311Packages.torchvision
            python311Packages.torchaudio
            python311Packages.einops
            python311Packages.transformers
            python311Packages.safetensors
            python311Packages.aiohttp
            python311Packages.pyyaml
            python311Packages.pillow
            python311Packages.scipy
            python311Packages.tqdm
            python311Packages.psutil
          ];
        };
      }
    );
}
