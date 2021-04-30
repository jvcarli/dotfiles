" vim:fileencoding=utf-8:ft=vim:foldmethod=marker

" {{{ Lua
lua << EOF

-- require Packer plugin config file --> `./lua/plugins.lua`
-- when possible plugin configuration is declared there
require('plugins')

-- LSP configuration
require('local-lsp-configuration')

-- KEYMAPS:
-- lsp-trouble.nvim
-- Toggle lsp-trouble with `Leader > e` keys
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>LspTroubleToggle<cr>",
  {silent = true, noremap = true}
)

-- }}}

-- {{{ Tokyonight theme config
vim.g.tokyonight_style = "dark" -- day / storm / night
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]
-- }}}

-- {{{ sneakvim
-- See: https://www.reddit.com/r/neovim/comments/jwd0qx/how_do_i_define_vim_variable_in_lua/
vim.g["sneak#label"] = 1
-- }}}

EOF
" }}}

" {{{ vimscript
"
" Some parts of this section are coded with vimscript because
" augroups and autocommands DO NOT have an interface yet,
" but is being worked on, see: https://github.com/neovim/neovim/pull/12378
" needed for nvim-bufferline (emacs centur tabs like)
"
" There is no equivalent to the :set command in Lua, you either set an option
" globally or locally. If you're setting options from your init.lua,
" some of them will require you to set both vim.o.{option} and vim.{wo/bo}.{option} to work properly.
" see: https://github.com/nanotee/nvim-lua-guide#caveats-3
" see: https://github.com/neovim/neovim/pull/13479
"

" {{{ Tabs, spaces, splits and panes configuration

set tabstop=4 " show <tab> charcter as 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab

" Golang: gofmt uses booth spaces and tabs so, tabs won't be expanded as usually
autocmd FileType go setlocal noexpandtab
	
" nvim panes
" open new split panes to right and below
set splitright
set splitbelow

" }}}

set termguicolors

autocmd BufWritePost plugins.lua PackerCompile

" {{{ Hybrid line numbers
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" }}}

" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
" }}}