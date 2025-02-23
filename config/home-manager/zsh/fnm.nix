{ config, pkgs, lib, ... }:
let
  fnmInstallScript = ''
    eval "$(fnm env)"
    for version in ${lib.concatStringsSep " " config.programs.fnm.versions}; do
      fnm install --arch x64 $version
    done
    fnm default ${config.programs.fnm.defaultVersion}
  '';
in
{
  options.programs.fnm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable fnm (Fast Node Manager)";
    };
    versions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["18.20.6" "20.18.3"];
      description = "List of Node.js versions to install with fnm";
    };
    defaultVersion = lib.mkOption {
      type = lib.types.str;
      default = "18.20.6";
      description = "Default Node.js version to set with fnm";
    };
  };

  config = lib.mkIf config.programs.fnm.enable {
    home.packages = [ pkgs.fnm ];

    home.activation = {
      fnm = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ${fnmInstallScript}
      '';
    };

    programs.zsh.initExtra = ''
      eval "$(fnm env)"
    '';
  };
}