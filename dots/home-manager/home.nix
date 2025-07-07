{ config, pkgs, lib, ... }:

let
    gruvboxplus = import ./gruvbox-plus.nix { inherit pkgs; };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sebastiant";
  home.homeDirectory = "/home/sebastiant";

  programs.git = {
    enable = true;
    userName = "Raaaainbow";
    userEmail = "seba7204@gmail.com";
  };

  gtk.enable = true;

  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
  };

  gtk.theme = {
    package = pkgs.gruvbox-gtk-theme;
    name = "GruvboxPlus";
  };

  gtk.iconTheme = {
    package = pkgs.gruvbox-dark-icons-gtk;
    name = "oomox-gruvbox-dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
  
programs.neovim = {
    enable = true;
    vimAlias = true;
    extraPackages = [
      # LSP servers
      pkgs.llvmPackages_20.clang-tools     
      pkgs.nil
      pkgs.jdt-language-server
      pkgs.lua-language-server
      pkgs.pyright
      pkgs.texlab
      pkgs.bash-language-server
      
      # Formatters
      pkgs.shfmt                    # Bash formatter
      pkgs.clang-tools              # C/C++ formatter (already included in clang-tools above)
      pkgs.google-java-format       # Java formatter
      pkgs.nixpkgs-fmt             # Nix formatter
      pkgs.black                    # Python formatter
      pkgs.python3Packages.isort    # Python import sorter
      pkgs.texlive.combined.scheme-medium # Includes latexindent for LaTeX formatting
      
      # Other dependencies
      pkgs.glib # NvimTree delete dependency
    ];
  };

  programs.bash = {
    enable = true;
    shellAliases = {
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    gruvbox-dark-icons-gtk
    pkgs.llvmPackages_20.clang-tools     
    pkgs.nil
    pkgs.jdt-language-server
    pkgs.lua-language-server
    pkgs.pyright
    pkgs.texlab
    appimage-run
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
