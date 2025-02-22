{ config, pkgs, lib, utils, ... }:
{
  imports = [
    ./profiles/desktop.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.nixpkgs/hosts/mic/configuration.nix
  environment.darwinConfig = "$HOME/.config/nix-darwin/configuration.nix";
}