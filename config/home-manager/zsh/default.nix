{ pkgs, ... }:
{
  imports = [
    ./fnm.nix
  ];
  
  programs.fzf = {
  enable = true;
  enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    history = {
      size = 100000;
      save = 2000000;
    };

    oh-my-zsh = {
      enable = true;
      # theme = "powerlevel10k/powerlevel10k";
      plugins = [
        "history"
        "git"
        # "zsh-autosuggestions"
        # "zsh-syntax-highlighting"
        "wd"
        "docker"
      ];
    };

    plugins = [
      {
        name = "nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
       {
        name = "powerlevel10k-config";
        src = ../zsh;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtra = ''
      # Detect which `ls` flavor is in use
      if ls --color > /dev/null 2>&1; then # GNU `ls`
              colorflag="--color"
              export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
      else # macOS `ls`
              colorflag="-G"
              export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
      fi

      # Always use color output for `ls`
      alias ls="command ls ''${colorflag}"

      # More colors!!!111
      export TERM='xterm-256color';

      export PATH="$PATH:/opt/homebrew/bin";

      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';

    shellAliases = {
      # Open notes
      notes = "code ~/notes/";

      # Reload the shell (i.e. invoke as a login shell)
      reload = "exec $SHELL -l";

      # Copy to clipboard
      pb = "pbcopy";

      vim = "nvim";
      vi = "nvim";

      # List files
      l = "lsd";
      ll = "lsd -l";
      la = "lsd -a";
      lla = "lsd -la";
      lt = "lsd --tree";
      
      # Node commands
      watch = "npm run watch";
      build = "npm run build";
      lint = "npm run lint";
    };

    dirHashes = {
      # Shortcuts for popular locations
      dl  = "$HOME/Downloads";
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      EDITOR = "nvim";

      # Oracle Instant Client
      PATH="/usr/local/lib/instantclient_19_8:$PATH";
      ORACLE_HOME=/usr/local/lib/instantclient_19_8;
      DYLD_LIBRARY_PATH=/usr/local/lib/instantclient_19_8;
      OCI_LIB_DIR=/usr/local/lib/instantclient_19_8;
      OCI_INC_DIR=/usr/local/lib/instantclient_19_8/sdk/include;
    };
  };
}