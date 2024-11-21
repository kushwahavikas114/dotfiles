let mapleader=" "
let config_dir = system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/"')

" if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
" 	echo "Downloading junegunn/vim-plug to manage plugins..."
" 	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
" 	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
" 	autocmd VimEnter * PlugInstall
" endif

if filereadable(config_dir . "autoload/plug.vim")
	call plug#begin(system('echo -n "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/plugged"'))
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'ptzz/lf.vim'
	Plug 'voldikss/vim-floaterm'
	Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
	Plug 'ap/vim-css-color'  " color code highlighting
	Plug 'neoclide/coc.nvim',        {'on': ['CocList', 'CocConfig'], 'branch': 'release'}
	" Plug 'KabbAmine/zeavim.vim'  ",     {'on': ['Zeavim', 'ZeavimV', 'ZVVisSelection', 'ZVOperator', 'ZVKeyDocset']}
	" Plug 'machakann/vim-verdin',     {'for': 'vim'}
	" Plug 'puremourning/vimspector',   {'for': 'python'}
	" Plug 'powerman/vim-plugin-AnsiEsc'
	" Plug 'junegunn/goyo.vim',        {'on': 'Goyo'}
	" Plug 'jreybert/vimagit'
	" Plug 'lukesmithxyz/vimling'
	" Plug 'vimwiki/vimwiki'
	" Plug 'vim-airline/vim-airline',  {'on': 'AirlineTheme'}
	" Plug 'vim-airline/vim-airline-themes',   {'on': 'AirlineTheme'}
	" Plug 'joshdick/onedark.vim'
	call plug#end()
endif

let g:Verdin#autocomplete = 1
let g:livepreview_previewer = 'zathura'
let g:tex_flavor = 'latex'

set title showmatch nowrap mouse=a scrolloff=5
set tabstop=2 shiftwidth=0
set cursorline linebreak
set number relativenumber
set splitbelow splitright
set updatetime=1000
set notermguicolors lazyredraw
set listchars=tab:\┆\  "│

syntax on
filetype plugin indent on
colorscheme vim
highlight NonText ctermfg=242
highlight ColorColumn ctermbg=238
highlight! link CursorColumn ColorColumn
autocmd FileType text,fstab setlocal tabstop=8 shiftwidth=8
autocmd FileType html setlocal tabstop=2 shiftwidth=2 list nolinebreak
autocmd FileType sql  setlocal commentstring=--\ %s
autocmd BufEnter bm-files,bm-dirs setlocal tabstop=8 shiftwidth=8
autocmd BufWritePost bm-files,bm-dirs silent !shortcuts
autocmd VimLeave *.tex !dev clean "%"
" autocmd BufWritePost config.h,config.def.h !cd "%:h"; rm -f config.h; sudo make install
autocmd BufWritePre  * %s/\s\+$//e
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

autocmd BufWritePost */Documents/Notes/*.md silent !pandoc % -o "$HOME/Documents/Notes/.out/$(basename % .md).html"
" autocmd BufWritePost */Documents/latex/resume/resume.tex !cd "%:h"; pdflatex resume.tex; cp -v resume.pdf ~/Dev/vikas.rocks/static/dox/
autocmd BufWritePost *Xresources silent !xrdb "%"
autocmd BufRead,BufNewFile *.yt* set filetype=conf

function SourceTemplate()
	let b:template = glob("${XDG_CONFIG_HOME:-$HOME/.config}/nvim/templates/_default." . expand('%:e'))
	if !empty(b:template)
		execute('0r' . b:template)
	endif
endfunction

autocmd BufNewFile * call SourceTemplate()

autocmd TermOpen * startinsert
command! -nargs=* T  split  | terminal <args>

" --> Scratch buffer
if exists('g:loaded_scratch')
  finish
endif
let g:loaded_scratch = 1
command! -nargs=1 -complete=command D call scratch#open(<q-args>, <q-mods>)

" --> Lf
" let g:lf_command_override = 'lf -command ...'
let g:NERDTreeHijackNetrw = 0
" let g:lf_replace_netrw = 1
let g:lf_width = 1.0
let g:lf_height = 1.0
let g:lf_map_keys = 0
nnoremap <Esc>o     :LfCurrentFile<CR>
nnoremap <Esc>l     :LfWorkingDirectory<CR>
nnoremap <leader>o  :LfCurrentFileNewTab<CR>
nnoremap <leader>l  :LfWorkingDirectoryExistingOrNewTab<CR>

if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap g; :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
nnoremap g1 1gt
nnoremap g2 2gt
nnoremap g3 3gt
nnoremap g4 4gt
nnoremap g5 5gt
nnoremap g6 6gt
nnoremap g7 7gt
nnoremap g8 8gt
nnoremap g9 :tablast<CR>

vnoremap <C-c> "*y :let @+=@*<CR>
vnoremap <C-A-c> "*d :let @+=@*<CR>
noremap <C-p> "+p
noremap <C-A-p> "+P

nnoremap c "_c
inoremap jk <Esc>
" map ;n /<++><Enter>c4l
inoremap ;n <Esc>/<++><Enter>c4l
nnoremap <leader>n /<++><Enter>c4l

autocmd FileType html,markdown inoremap ;s ><Esc>bi<<Esc>ea
autocmd FileType html,markdown inoremap ;c ><Esc>bi</<Esc>ea
autocmd FileType html,markdown inoremap ;i <Esc>b"tywi<<Esc>ea></><Esc>PF<i
autocmd FileType html,markdown inoremap ;I <Esc>b"tywi<<Esc>ea><++></><Esc>P2F>i<Space>
autocmd FileType html,markdown inoremap ;b <Esc>b"tywi<<Esc>ea><CR></<Esc>"tpa><CR><++><Esc>kO
autocmd FileType html,markdown inoremap ;B <Esc>b"tywi<<Esc>ea><CR><++><CR></<Esc>"tpa><CR><++><Esc>3k$i<Space>
autocmd FileType html,markdown inoremap ;ap <p><CR><++><CR></p><CR><++><Esc>3k$i
autocmd FileType html,markdown inoremap ;aa <a href=""><CR><++><CR></a><CR><++><Esc>3k$hi

autocmd FileType tex inoremap ;b <Esc>b"tywi\begin{<Esc>ea}<CR>\end{<Esc>"tpa}<Esc>kA
autocmd FileType tex inoremap ;s \section{}<Esc>i
autocmd FileType tex inoremap ;at \begin{tikzpicture}<CR>\end{tikzpicture}<Esc>O
autocmd FileType tex inoremap ;ap \usepackage{}<Esc>i
autocmd FileType tex inoremap ;aP \usepackage[]{}<Esc>F[a
autocmd FileType tex inoremap ;ab \textbf{}<Esc>i
autocmd FileType tex inoremap ;ai \textit{}<Esc>i
autocmd FileType tex inoremap ;au \underline{}<Esc>i

autocmd FileType go inoremap ;ae err<Space>:=<Space><++><CR>if<Space>err<Space>!=<Space>nil<Space>{<CR>return<Space>err<CR>}<Esc>3kI

nnoremap <leader>fl :w<CR>:!dev lint "%"<CR>
nnoremap <leader>fm :w<CR>:%!dev format "%"<CR>
nnoremap <leader>fc :w<CR>:!dev compile "%"<CR>
nnoremap <leader>fe :w<CR>:!dev run "%"<CR>
nnoremap <leader>ft :w<CR>:!dev test "%"<CR>
nnoremap <leader>fr :w<CR>:!dev clean "%"<CR>

nnoremap <leader>Fl :w<CR>:T dev lint "%"<CR>
nnoremap <leader>Fm :w<CR>:T dev format "%"<CR>
nnoremap <leader>Fc :w<CR>:T dev compile "%"<CR>
nnoremap <leader>Fe :w<CR>:T dev run "%"<CR>
nnoremap <leader>Ft :w<CR>:T dev test "%"<CR>
nnoremap <leader>Fr :w<CR>:T dev clean "%"<CR>

autocmd BufEnter * nmap <leader>t :w<CR>:se nornu<CR>:!dev test "%"<CR>:se rnu<CR>
autocmd BufEnter * nmap <leader>T :w<CR>:se nornu<CR>:T dev test "%"<CR>
autocmd BufEnter * imap <F5> <Esc>:w<CR>:se nornu<CR>:T dev test "%"<CR>

autocmd BufEnter vartak-results-data.pl nmap <leader>t :w<CR>:se nornu<CR>:!vartak-results-data.pl ~/GDrive/vartak/results/university/1S002557.pdf<CR>:se rnu<CR>

nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>fo :!opout "%:p"<CR>
nnoremap <leader>ec :tabnew ~/.config/nvim/init.vim<CR>
nnoremap <leader><C-r> :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>s :%s//gc<Left><Left><Left>
nnoremap <leader>r :w<CR>:!%:p<CR>
nnoremap <leader>R :w<CR>:T %:p<CR>

nnoremap <leader>gc :T git add --all && git commit<CR>

let shortcuts = config_dir . "shortcuts.vim"
if filereadable(shortcuts)
	execute "source " . shortcuts
endif
