{
  description = "Nix Package Manager";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    nixPkgs = with pkgs; buildEnv {
      name = "nixPkgs";
      paths = [
        atuin
        carapace
        eza
        fastfetch
        lazygit
        mise
        neovim
        sheldon
        starship
        vivid
        zoxide
      ];
    };

  in {
    packages.${system}.default = nixPkgs;
  };
}
