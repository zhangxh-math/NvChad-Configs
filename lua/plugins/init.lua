return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_quickfix_mode = 0
    end,
  },
  {
    "SirVer/ultisnips",
    lazy = false,
    config = function()
      vim.g.UltiSnipsSnippetDirectories = {'ultisnips'}
      vim.g.UltiSnipsExpandTrigger = '<tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'
    end,
  },
  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          {open = "'", close = "'"},
          {open = '"', close = '"'},
          {open = '`', close = '`'},
          {open = '(', close = ')'},
          {open = '[', close = ']'},
          {open = '{', close = '}'}
        },
        ignore_beginning = true -- if tabout should ignore the beginning of a filled element
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = {
        highlight = {
          additional_vim_regex_highlighting = {"latex"},
        },
      }
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    config = function()
      local cmp = require 'cmp'
      local lspkind = require('lspkind')
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = cmp.mapping({
--        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--        ['<C-f>'] = cmp.mapping.scroll_docs(4),
--        ['<C-Space>'] = cmp.mapping.complete(),
--        ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Down>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#ExpandSnippet()<CR>", true, true, true), 'n', true)
            elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#JumpForwards()<CR>", true, true, true), 'n', true)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<Up>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#JumpBackwards()<CR>", true, true, true), 'n', true)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'vimtex', priority = 8 },
          { name = 'nvim_lsp', priority = 7 },
          { name = 'ultisnips', priority = 10 },
          { name = 'spell', priority = 9 },
          { name = 'path', priority = 6 },
        }),
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              vimtex = "{TEX}",
              nvim_lsp = "[LSP]",
              ultisnips = "[Snip]",
              spell = "[Spell]",
              path = "[Path]",
            }
          }),
        },
      }
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
  },
  {
    "hrsh7th/cmp-path",
    lazy = false,
  },
  {
    "quangnguyen30192/cmp-nvim-ultisnips",
    lazy = false,
  },
  {
    "f3fora/cmp-spell",
    lazy = false,
  },
  {
    "onsails/lspkind-nvim",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local lspconfig = require('lspconfig')
        local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

        -- Function to setup diagnostics signs
        local function setup_diagnostics_signs(bufnr)
            for type, icon in pairs(signs) do
                local sign = "LspDiagnosticsSign" .. type
                vim.fn.sign_define(sign, { text = icon, texthl = sign, numhl = "" })
            end
            vim.lsp.diagnostic.show_line_diagnostics({ focusable = false, border = "single" })
        end

        -- Configure LSP servers for LaTeX, Lua, and Python
        local servers = { "texlab", "lua_ls", "pyright" }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                on_attach = function(client, bufnr)
                    setup_diagnostics_signs(bufnr)
                end
            }
        end
    end
  }
}

