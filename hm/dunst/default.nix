{ pkgs, ... }:
{
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      follow = "keyboard";
      notification_limit = 3;
      origin = "top-center";
      layer = "overlay";
    };
    urgency_low.timeout = 5;
    urgency_normal.timeout = 10;
    urgency_critical.timeout = 30;
  };
}
