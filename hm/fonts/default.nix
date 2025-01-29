{ pkgs, ... }:
{
  fonts ={
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      jetbrains-mono
      font-awesome
      liberation_ttf
      mplus-outline-fonts
      nerdfonts
      noto-fonts
      noto-fonts-emoji
      proggyfonts
      gyre-fonts
      ubuntu_font_family
    ];
  }; 
}
