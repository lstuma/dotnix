{ lib, config, ... }:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    
    theme = 
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "#window" = {
        enabled = true;
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        width = mkLiteral "600px";
        margin = mkLiteral "0px";
        padding = mkLiteral "5px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "10px";
      };
      "#mainbox" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "30px";
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
        padding = "10px 0 10px 15px";
        placeholder = "Search...";
        placeholder-colon = "inherit";
        blink = true;
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
