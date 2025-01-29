# Common Nix
{ ... }: {
  imports = [ ];
  hardware.opengl.enable = true;

  xdg.portal.wlr.enable = true;
  services.dbus.enable = true;
}
