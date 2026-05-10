-- ============================================================
-- Bootstrap vim-plug
-- ============================================================
local plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.fn.system({
    'curl', '-fLo', plug_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
  })
  vim.api.nvim_create_autocmd('VimEnter', {
    once     = true,
    callback = function() vim.cmd('PlugInstall --sync | source $MYVIMRC') end,
  })
end

-- ============================================================
-- Plugins
-- ============================================================
local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')
  Plug 'knsh14/vim-github-link'
  Plug 'zivyangll/git-blame.vim'
  Plug 'github/copilot.vim'
  Plug 'fatih/molokai'
  Plug 'tyru/caw.vim'
  Plug 'Shougo/vinarise'

  -- lightline → lualine
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-tree/nvim-web-devicons'

  -- NERDTree → nvim-tree
  Plug 'nvim-tree/nvim-tree.lua'

  -- CtrlP → telescope
  Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
  Plug 'nvim-lua/plenary.nvim'

  -- LSP server manager (nvim-lspconfig は Neovim 0.11+ では不要)
  Plug 'williamboman/mason.nvim'

  -- vim-goimports → gopls + codeAction on save (LSP セクション参照)
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
vim.call('plug#end')

-- ============================================================
-- Options
-- ============================================================
local opt = vim.opt

opt.clipboard    = 'unnamedplus'
opt.timeout      = true
opt.timeoutlen   = 1000
opt.wildmenu     = true
opt.number       = true
opt.cursorline   = true
opt.cursorcolumn = true
opt.scrolloff    = 4
opt.showmatch    = true
opt.expandtab    = true
opt.tabstop      = 2
opt.shiftwidth   = 2
opt.backspace    = 'indent,eol,start'
opt.autoindent   = true
opt.smartindent  = true
opt.hlsearch     = true
opt.mouse        = 'a'
opt.laststatus   = 2
opt.whichwrap    = 'b,s,h,l,<,>,[,],~'

-- ============================================================
-- Keymaps
-- ============================================================
local map = vim.keymap.set

map({ 'n', 'v' }, '<S-h>', '^')
map({ 'n', 'v' }, '<S-l>', '$')
map({ 'n', 'v' }, '<S-j>', '5j')
map({ 'n', 'v' }, '<S-k>', '5k')

map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')

map('v', 'u', '<Nop>')
map({ 'n', 'v' }, ';', ':')
map('n', '<Leader>x', '<cmd>noh<CR>')

-- git-blame
map('n', '<Leader>g', function() vim.fn['gitblame#echo']() end)

-- vim-github-link
map('v', 'gt', ':GetCurrentBranchLink<CR>')

-- caw.vim
map({ 'n', 'v' }, '<Leader>c', '<Plug>(caw:hatpos:toggle)')
map({ 'n', 'v' }, '<Leader>,', '<Plug>(caw:zeropos:toggle)')

-- ============================================================
-- Autocmds
-- ============================================================
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[%s/\s\+$//ge]],
})

-- ============================================================
-- Colorscheme
-- ============================================================
vim.g.molokai_original = 1
vim.g.rehash256        = 1
pcall(vim.cmd, 'colorscheme molokai')

-- ============================================================
-- lualine
-- ============================================================
local ok_lualine, lualine = pcall(require, 'lualine')
if ok_lualine then
  lualine.setup({ options = { theme = 'molokai' } })
end

-- ============================================================
-- nvim-tree
-- ============================================================
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

local ok_tree, nvim_tree = pcall(require, 'nvim-tree')
if ok_tree then
  local tree_api = require('nvim-tree.api')

  local function on_attach_tree(bufnr)
    tree_api.config.mappings.default_on_attach(bufnr)

    -- ファイルを開いていなければ nvim ごと閉じる
    vim.keymap.set('n', 'q', function()
      local real_bufs = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_valid(buf)
          and vim.bo[buf].buflisted
          and vim.api.nvim_buf_get_name(buf) ~= ''
      end, vim.api.nvim_list_bufs())

      if #real_bufs == 0 then
        vim.cmd('qall')
      else
        tree_api.tree.close()
      end
    end, { buffer = bufnr, noremap = true, silent = true })
  end

  nvim_tree.setup({
    on_attach = on_attach_tree,
    filters  = {
      dotfiles = false,
      custom   = { '\\.class$', '\\.swp$', '\\.pdf', '^.git$' },
    },
    renderer = { icons = { show = { git = true } } },
    view     = { width = 30 },
  })

  map('n', '<C-t>', '<cmd>NvimTreeToggle<CR>')
  map('n', '<C-f>', '<cmd>NvimTreeFindFile<CR>')

  -- 引数なしで起動したとき自動で開く
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      if vim.fn.argc() == 0 then
        require('nvim-tree.api').tree.open()
      end
    end,
  })

  -- nvim-tree だけ残ったら自動で終了
  vim.api.nvim_create_autocmd('BufEnter', {
    nested   = true,
    callback = function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      local non_tree = vim.tbl_filter(function(w)
        return vim.bo[vim.api.nvim_win_get_buf(w)].filetype ~= 'NvimTree'
      end, wins)
      if #non_tree == 0 then vim.cmd('quit') end
    end,
  })

  -- nvim-tree フォーカス中に :q で qall と同じ挙動にする
  vim.api.nvim_create_autocmd('QuitPre', {
    callback = function()
      if vim.bo.filetype ~= 'NvimTree' then return end
      local real_bufs = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_valid(buf)
          and vim.bo[buf].buflisted
          and vim.api.nvim_buf_get_name(buf) ~= ''
          and vim.bo[buf].filetype ~= 'NvimTree'
      end, vim.api.nvim_list_bufs())
      if #real_bufs == 0 then
        vim.schedule(function() vim.cmd('qall') end)
      end
    end,
  })
end

-- ============================================================
-- telescope
-- ============================================================
local ok_telescope, builtin = pcall(require, 'telescope.builtin')
if ok_telescope then
  map('n', '<C-p>',      builtin.find_files)
  map('n', '<Leader>fg', builtin.live_grep)
  map('n', '<Leader>fb', builtin.buffers)
end

-- ============================================================
-- LSP (Neovim 0.11+ native: vim.lsp.config / vim.lsp.enable)
-- ============================================================
local ok_mason, mason = pcall(require, 'mason')
if ok_mason then
  mason.setup()

  -- 初回起動時に gopls と lua-language-server を自動インストール
  local ok_reg, registry = pcall(require, 'mason-registry')
  if ok_reg then
    registry.refresh(function()
      for _, pkg_name in ipairs({ 'gopls', 'lua-language-server' }) do
        local ok, pkg = pcall(registry.get_package, pkg_name)
        if ok and not pkg:is_installed() then
          vim.notify('Mason: installing ' .. pkg_name, vim.log.levels.INFO)
          pkg:install()
        end
      end
    end)
  end
end

-- cmp の capabilities を全サーバーに適用
local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp_lsp then
  vim.lsp.config('*', {
    capabilities = cmp_nvim_lsp.default_capabilities(),
  })
end

-- LspAttach でキーマップを設定 (全サーバー共通)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local o = { buffer = args.buf }
    map('n', 'gd',         vim.lsp.buf.definition,  o)
    map('n', 'K',          vim.lsp.buf.hover,        o)
    map('n', '<Leader>rn', vim.lsp.buf.rename,       o)
    map('n', '<Leader>ca', vim.lsp.buf.code_action,  o)
    map('n', 'gr',         vim.lsp.buf.references,   o)
  end,
})

-- gopls
vim.lsp.config('gopls', {
  cmd          = { 'gopls' },
  filetypes    = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  settings     = { gopls = { gofumpt = true } },
})
vim.lsp.enable('gopls')

-- lua_ls
vim.lsp.config('lua_ls', {
  cmd          = { 'lua-language-server' },
  filetypes    = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings     = {
    Lua = {
      runtime   = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.enable('lua_ls')

-- goimports on save (vim-goimports の代替)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern  = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})

-- ============================================================
-- nvim-cmp
-- ============================================================
local ok_cmp,  cmp     = pcall(require, 'cmp')
local ok_snip, luasnip = pcall(require, 'luasnip')

if ok_cmp and ok_snip then
  cmp.setup({
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>']     = cmp.mapping.abort(),
      ['<CR>']      = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources(
      { { name = 'nvim_lsp' }, { name = 'luasnip' } },
      { { name = 'buffer' } }
    ),
  })
end

-- ============================================================
-- Vinarise (binary viewer)
-- ============================================================
local bin_grp = vim.api.nvim_create_augroup('BinaryXXD', { clear = true })

vim.api.nvim_create_autocmd('BufReadPre', {
  group    = bin_grp,
  pattern  = '*.bin',
  callback = function() vim.opt_local.binary = true end,
})

for _, ev in ipairs({ 'BufReadPost', 'BufWritePre', 'BufWritePost' }) do
  vim.api.nvim_create_autocmd(ev, {
    group    = bin_grp,
    pattern  = '*',
    callback = function()
      if vim.opt_local.binary:get() then vim.cmd('Vinarise') end
    end,
  })
end
