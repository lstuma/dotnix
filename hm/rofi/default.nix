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
        padding = "30px";
      };
      "#inputbar" = {
        spacing = "10px";
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "0px";
      };
      "#prompt" = { 
      };
      "#textbox-prompt-colon" = {
        padding = "5px";
        expand = false;
        str = "";
      };
      "#entry" = {
        padding = "5px 0px";
        placeholder = "Search...";
        placeholder-colon = "inherit";
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
