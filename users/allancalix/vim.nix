{}:
''
if &compatible
  set nocompatible
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set hidden

" GENERAL
set backspace=indent,eol,start
set ruler
set wildmenu

let g:coq_settings = { 'auto_start': 'shut-up', 'display.pum.fast_close': v:false, 'xdg': v:true }
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set autowrite
set autoread

" SEARCH
set inccommand=nosplit
set incsearch
set hlsearch

" configure the invisible chars
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set smartcase
set smarttab
set autoindent
set ignorecase

set backupdir=~/.vim/tmp/                   " for the backup files
set directory=~/.vim/tmp/                   " for the swap files

set textwidth=120
set nowrap " wrapping is really annoying when working with html/jsx files
set colorcolumn=81
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" FILE EXPLORER
let g:netrw_banner = 0
let g:netrw_sort_sequence = '[\/]$,*'
let g:netrw_list_hide = '^bazel-.*$,^node_modules'
let g:netrw_hide = 1

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"================THEMES==================
set termguicolors     " enable true colors support
let ayucolor="mirage" " light | mirage | dark
colorscheme ayu

"=================TABULAR==================

" Align on equal sign
vnoremap <silent> <Leader>cee    :Tabularize /=<CR>              "tabular
" Align on # sign (comment)
vnoremap <silent> <Leader>cet    :Tabularize /#<CR>             "tabular
" Align (no sign)
vnoremap <silent> <Leader>ce     :Tabularize /

"==================KEYS====================
let mapleader = ','

" use jj to quickly escape to normal mode while typing <- AWESOME tip
inoremap jj <ESC>
inoremap <C-L> <ESC>

" insert newline without entering insert mode
map <CR> o<Esc>k

" reloads .vimrc -- making all changes active
map <F1> <Esc>
imap <F1> <Esc>

" Leader C prefix is for code related mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <F5> :call LanguageClient_contextMenu()<CR>
noremap <silent> <Leader>c? :call LanguageClient#textDocument_hover()<CR>
noremap <silent> <Leader>cn :call LanguageClient#textDocument_rename()<CR>

noremap <silent> <Leader>cc          :TComment<CR>              "tcomment_vim

" Hotkey for removing trailing whitespace in a file
noremap <silent> <Leader>cw          :%s/[ \t]*$//g<CR>

" Leader F prefix is for file related mappings (open, browse...)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --ignore\ --hidden
nnoremap <silent> <Leader>ff :Telescope find_files find_command=fd prompt_prefix=🔍<CR>
nnoremap <silent> <Leader>fg :Telescope git_files prompt_prefix=🔍<CR>
nnoremap <silent> <Leader>fr :Telescope live_grep prompt_prefix=🔍<CR>
nnoremap <silent> <Leader>fb :Telescope buffers prompt_prefix=🔍<CR>
nnoremap <silent> <Leader>fm :lua require'telescope.builtin'.marks{}<CR>
nnoremap <silent> <Leader>fd :lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>
nnoremap <silent> <Leader>fe :Explore<CR>

nnoremap <silent> <Leader>cs :lua require'telescope.builtin'.lsp_document_symbols{}<CR>

" Leader B prefix is for buffer related mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <Leader>bb :bn<CR>
nnoremap <silent> <Leader>bd :bdelete<CR>

" (un)lock the current buffer to prevent modification
nnoremap <silent> <Leader>bl :set nomodifiable<CR>
nnoremap <silent> <Leader>bu :set modifiable<CR>

lua <<EOF
options = {theme = 'ayu_mirage'}
require'lualine'.setup{
  options = options,
}

local nvim_lsp = require('lspconfig')
local coq = require('coq')
vim.api.nvim_set_keymap("n", "<Leader>mt", ":lua require('checklist').toggle_item()<CR>", { noremap = true, silent = true })

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup (coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }))

require'lspconfig'.rescriptls.setup (coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  cmd = {
    'node',
    '/usr/local/share/acx/pkg/third_party/rescript-vscode/extension/server/out/server.js',
    '--stdio',
  }
}))

end
EOF
''
