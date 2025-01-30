{ lib, config, ... }:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";

    theme = {
      "#window" = {
        enabled = true;
        location = "center";
        anchor = "center";
        width = "600px";
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "10px";
      };
      "#mainbox" = {
        enabled = true;
        spacing = "10px";
        margin = "0px";
        padding = "30px";
      };
      "#inputbar" = {
        enabled = true;
        spacing = "10px";
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "0px";
      };
      "#prompt" = { 
        enabled = true;
      };
      "#textbox-prompt-colon" = {
        enabled = true;
        padding = "5px";
        expand = false;
        str = "";
      };
      "#entry" = {
        enabled = true;
        padding = "5px 0px";
        placeholder = "Search...";
        placeholder-colon = "inherit";
      };
      "#num-filtered-rows" = {
        enabled = true;
        expand = false;
      };
      "#textbox-num-sep" = {
        enabled = true;
        expand = false; 
        str = "/";
      };
      "#num-rows" = {
        enabled = true;
        expand = false;
      };
      "#case-indicator" = {
        enabled = true;
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
