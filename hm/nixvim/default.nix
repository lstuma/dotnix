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
      navic = {
        enable = true;
        settings = {
          separator = "  ";
          highlight = true;
          depthLimit = 5;
          lsp = {
            autoAttach = true;
          };
          icons = {
            Array = "󱃵  ";
            Boolean = "  ";
            Class = "  ";
            Constant = "  ";
            Constructor = "  ";
            Enum = " ";
            EnumMember = " ";
            Event = " ";
            Field = "󰽏 ";
            File = " ";
            Function = "󰡱 ";
            Interface = " ";
            Key = "  ";
            Method = " ";
            Module = "󰕳 ";
            Namespace = " ";
            Null = "󰟢 ";
            Number = " ";
            Object = "  ";
            Operator = " ";
            Package = "󰏖 ";
            String = " ";
            Struct = " ";
            TypeParameter = " ";
            Variable = " ";
          };
        };
      };
      bufferline = {
        enable = true;
        settings = {
          options = {
            diagnostics = "nvim_lsp";
            mode = "buffers";

            close_icon = "󰅚 ";
            buffer_close_icon = " ";
            modified_icon =" ";
            
            offsets = [
              {
                filetype = "neo-tree";
                text = "Neo-tree";
                highlight = "Directory";
                text_align = "left";
              }
            ];
          };
        };
      };
      guess-indent = {
        enable = true;
      };
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
          };
        };
      };
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            enabled = true;
          };
          panel = {
            enabled = true;
          };
        };
      };
      copilot-chat = {
        enable = true;
      };
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    opts = {
      number = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          desc = "Toggle Neo-tree file explorer";
        };
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>BufferLineCycleNext<cr>";
        options = {
          desc = "Cycle to next buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>p";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options = {
          desc = "Cycle to previous buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>bdelete<cr><cmd>BufferLineCycleNext<cr><cmd>bdelete<cr>";
        options = {
          desc = "Delete current puffer and then cycle to next buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>cp";
        action = "<cmd>Copilot toggle<cr>";
        options = {
          desc = "Toggle copilot completions";
        };
      }
      {
        mode = "n";
        key = "<leader>ct";
        action = "<cmd>CopilotChatToggle<cr>";
        options = {
          desc = "Toggle copilot chat window";
        };
      }
    ];
  };
}
