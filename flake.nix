# See https://github.com/nix-community/nix-environments/issues/81#issuecomment-2468180653
{
  description = "A Nix flake based Yocto development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nix-environments = {
      url = "github:nix-community/nix-environments";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nix-environments, ... }: let
    system = "x86_64-linux";
  in {
    devShell.${system} = let
      pkgs = import nixpkgs { inherit system; };
      yocto = import (builtins.toPath nix-environments.outPath + "/envs/yocto/shell.nix") {
        inherit pkgs;
        extraPkgs = with pkgs; [
          kas
        ];
      };
    in yocto;
  };
}
