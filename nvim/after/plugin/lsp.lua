local lsp_zero = require('lsp-zero')

lsp_zero.preset('recommended')
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'clangd',
  'jdtls',
  'pyright',
  'lua_ls',
  'kotlin_language_server'},
  automatic_installation = false,
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    pyright = function()
	    require('lspconfig').pyright.setup({
	    filetypes={'python'},
	    })
    end,
    jdtls = lsp_zero.noop,
  },
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	['<C-Space>'] = cmp.mapping.complete(),
})
cmp.setup({
	mapping = cmp_mappings
})
lsp_zero.setup()
