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

            show_buffer_icons = true;
            show_buffer_close_icons = true;
            show_close_icon = true;
            show_tab_indicators = true;
            
            seperator_style = "thin";
            enfore_regular_tabs = false;
            always_show_bufferline = true;

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
        settings = {
          auto_insert_mode = true;

        };
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
        key = "<C-w><C-Left>";
        action = "<C-w>H";
        options = {
          desc = "Move window to left";
        };
      }
      {
        mode = "n";
        key = "<C-w><C-Right>";
        action = "<C-w>L";
        options = {
          desc = "Move window to right";
        };
      }
      {
        mode = "n";
        key = "<C-w><S-Right>";
        action = "<cmd>resize +1<cr>";
        options = {
          desc = "Horizontally upsize window";
        };
      }
      {
        mode = "n";
        key = "<C-w><S-Left>";
        action = "<cmd>resize -1<cr>";
        options = {
          desc = "Horizontally downsize window";
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
        key = "<C-A-Right>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options = {
          desc = "Alias for <leader>n";
        };
      }
      {
        mode = "n";
        key = "<C-A-Left>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options = {
          desc = "Alias for <leader>p";
        };
      }
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>bdelete<cr><cmd>BufferLineCycleNext<cr>";
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
