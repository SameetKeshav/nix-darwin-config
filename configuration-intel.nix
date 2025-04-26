{ config, pkgs, lib, utils, ... }:
{
  imports = [
    ./profiles/Intel-Macbook-Pro/desktop.nix
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";

  # users.groups.nixbld.gid = 350;
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.nixpkgs/hosts/mic/configuration.nix
  environment.darwinConfig = "$HOME/.config/nix-darwin/configuration.nix";
  nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = false;

            # User owning the Homebrew prefix
            user = "sameetkeshav";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
}