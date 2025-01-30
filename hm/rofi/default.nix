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
        padding = "5px";
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
        border-radius = "0px";
        children = [
          "textbox-prompt-colon"
          "entry"
        ];
      };
      "#prompt" = { 
        enabled = false;
      };
      "#textbox-prompt-colon" = {
        margin = "10px";
        expand = false;
        str = "";
      };
      "#entry" = {
        padding = "10px 15px";
        placeholder = "Search...";
        placeholder-colon = "inherit";
      };
      "#num-filtered-rows" = {
        expand = false;
      };
      "#textbox-num-sep" = {
        expand = false; 
        str = "/";
      };
      "#num-rows" = {
        expand = false;
      };
      "#listview" = {
        columns = 1;
        lines = 8;
        cycle = true;
        scrollbar = true;
        dynamic = true;
        layout = "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true; 

        spacing = "5px";
        margin = "0px";
        padding = "0px";
        border = "0px solid";
        border-radius = "0px";
      };
      "#scrollbar" = {
        handle-width = "5px";
        border-radius = "10px";
      };
      "#element" = {
        padding = "5px 10px";
        border = "0px solid";
      };
      "#element-icon" = {
        size = "24px";
      };
      "#element-text" = {
        veritcal-align = "0.5";
        horizontal-align = "0.5";
      };
    };
  };
}
