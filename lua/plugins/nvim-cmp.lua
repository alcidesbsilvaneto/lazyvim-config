return {
  "hrsh7th/nvim-cmp",
  opts = function()
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()

    return {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:CmpPmenu,CursorLine:CmpCursorLine,Search:None,CmpItemAbbr:@variable",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:CmpPmenu,CursorLine:CmpCursorLine,Search:None,CmpItemAbbr:@variable",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<Tab>"] = cmp.mapping(function(fallback)
          if require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(entry, item)
          -- Icons
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] and item.kind ~= "Color" then
            item.kind = icons[item.kind] .. item.kind
          end

          -- Handling duplicates

          if item.kind == "Color" then
            local tailwindFormattedItem = require("tailwindcss-colorizer-cmp").formatter(entry, item)
            item.kind = " "
            item.kind_hl_group = tailwindFormattedItem.kind_hl_group
          end

          return item
        end,
      },
      sorting = defaults.sorting,
    }
  end,
}
