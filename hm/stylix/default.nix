{ lib, pkgs, ... }:
{
home.packages = with pkgs; [
    gradience
  ];

  gtk = {
    enable = true;
    theme = {
      name = lib.mkForce "adw-gtk3-dark";
      package = lib.mkForce pkgs.adw-gtk3;
    };
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus";
  
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
	    '';
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };   
  home.sessionVariables.GTK_THEME = "adw-gtk3-dark";

  stylix = {
    enable = true;
    polarity = "dark";
    iconTheme = {
      package = pkgs.papirus-icon-theme.override { color = "indigo"; };
      dark = "Papirus-Dark"; # used
      light = "Papirus-Light"; # unused
    };
  };
}
