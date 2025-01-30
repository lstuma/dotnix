{ lib, config, ... }:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";

    theme = {
      "#window" = {
        location = "center";
        anchor = "center";
        width = "600px";
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "10px";
      };
      "#mainbox" = {
        spacing = "10px";
        margin = "0px";
      };
      "#inputbar" = {
        spacing = "10px";
        margin = "0px";
        padding = "0px";
      };
      "#prompt" = {

      };
      "#textbox-prompt-colon" = {

      };
      "#entry" = {

      };
      "#num-filtered-rows" = {

      };
      "#textbox-num-sep" = {
      
      };
      "#num-rows" = {

      };
      "#case-indicator" = {

      };
      "#listview" = {

      };
      "#scrollbar" = {

      };
      "#element" = {

      };

    };
  };
}
