{ lib, config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;
      };
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
        folding = false;
        nixvimInjections = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      };
      illuminate = {
        enable = true;
        underCursor = false;
        filetypesDenylist = [
          "Outline"
          "TelescopePrompt"
          "alpha"
          "harpoon"
          "reason"
        ];
      };
      neo-tree = {
        enable = true;
        sources = [
          "filesystem"
          "buffers"
          "document_symbols"
        ];
        addBlankLineAtTop = false;
        filesystem = {
          bindToCwd = false;
          followCurrentFile = {
            enabled = true;
          };
        };
        defaultComponentConfigs = {
          indent = {
            withExpanders = true;
            expanderCollapsed = "󰅂";
            expanderExpanded = "󰅀";
            expanderHighlight = "NeoTreeExpander";
          };
        };
      };
    };
  };
}
