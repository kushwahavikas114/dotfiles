" --> Onedark Theme
if exists('+termguicolors')
	let g:airline_theme = 'onedark'
	let g:onedark_terminal_italics = 1
	let g:onedark_color_overrides = {
      \ "foreground": { "gui": "#BBC2CF", "cterm": "145", "cterm16": "NONE" },
      \ "background": { "gui": "#181C24", "cterm": "235", "cterm16": "NONE" },
      \ "comment_grey": { "gui": "#6C7380", "cterm": "59", "cterm16": "7" },
      \ "gutter_fg_grey": { "gui": "#6272A4", "cterm": "238", "cterm16": "8" },
      \ "special_grey": { "gui": "#5Ba078", "cterm": "238", "cterm16": "7" },
			\ }
      " \ "background": { "gui": "#202426", "cterm": "235", "cterm16": "NONE" },
			"
      " \ "red": { "gui": "#E06C75", "cterm": "204", "cterm16": "1" },
      " \ "dark_red": { "gui": "#BE5046", "cterm": "196", "cterm16": "9" },
      " \ "green": { "gui": "#98C379", "cterm": "114", "cterm16": "2" },
      " \ "yellow": { "gui": "#E5C07B", "cterm": "180", "cterm16": "3" },
      " \ "dark_yellow": { "gui": "#D19A66", "cterm": "173", "cterm16": "11" },
      " \ "blue": { "gui": "#61AFEF", "cterm": "39", "cterm16": "4" },
      " \ "purple": { "gui": "#C678DD", "cterm": "170", "cterm16": "5" },
      " \ "cyan": { "gui": "#56B6C2", "cterm": "38", "cterm16": "6" },
      " \ "black": { "gui": "#282C34", "cterm": "235", "cterm16": "0" },
      " \ "white": { "gui": "#ABB2BF", "cterm": "145", "cterm16": "15" },
      " \ "cursor_grey": { "gui": "#2C323C", "cterm": "236", "cterm16": "0" },
      " \ "visual_grey": { "gui": "#3E4452", "cterm": "237", "cterm16": "8" },
      " \ "menu_grey": { "gui": "#3E4452", "cterm": "237", "cterm16": "7" },
      " \ "vertsplit": { "gui": "#3E4452", "cterm": "59", "cterm16": "7" },

	" autocmd ColorScheme * call onedark#extend_highlight("LineNr", {
	" 			\ "fg": { "gui": "#6272A4", "cterm": "238", "cterm16": "8" },
	" 			\ })
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  " set termguicolors noshowmode
	colorscheme onedark
	" autocmd VimEnter * AirlineTheme
endif

