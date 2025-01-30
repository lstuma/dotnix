{ lib, config, ... }:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    extraConfig = {
      show-icons = true;
    };
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
        spacing = mkLiteral "10px";
        border-radius = mkLiteral "0px";
        children = map mkLiteral [
          "textbox-prompt-colon"
          "entry"
        ];
      };
      "#prompt" = { 
        enabled = false;
      };
      "#textbox-prompt-colon" = {
        padding = mkLiteral "5px 10px";
        expand = false;
        str = "";
      };
      "#entry" = {
        padding = mkLiteral "5px 0px";
        placeholder = "Search...";
        placeholder-colon = mkLiteral "inherit";
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
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true; 

        spacing = mkLiteral "5px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
      };
      "#scrollbar" = {
        handle-width = mkLiteral "5px";
        border-radius = mkLiteral "10px";
      };
      "#element" = {
        padding = mkLiteral "5px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "5px";
      };
      "#element-icon" = {
        size = mkLiteral "24px";
      };
      "#element-text" = {
        veritcal-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
    };
  };
}
