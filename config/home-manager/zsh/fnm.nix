{ config, pkgs, lib, ... }:
{
  programs.fnm = {
    enable = true;
    versions = [ "18.20.6" "20.18.3" ]; # Specify the versions you want to install
    defaultVersion = "18.20.6"; # Set the default version
  };

  home.packages = [
    pkgs.fnm
  ];

  home.sessionVariables = {
    FNM_DIR = "$HOME/.fnm";
    PATH = "${config.home.homeDirectory}/.fnm:${config.home.homeDirectory}/.fnm/aliases/default/bin:$PATH";
  };

  home.activation = {
    fnm = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p $HOME/.fnm
      eval "$(fnm env)"
      for version in ${lib.concatStringsSep " " config.programs.fnm.versions}; do
        fnm install --arch x64 $version
      done
      fnm default ${config.programs.fnm.defaultVersion}
    '';
  };
}