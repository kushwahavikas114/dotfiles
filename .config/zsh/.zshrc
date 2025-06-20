#############################
##   SHELL CONFIGURATION   ##
#############################

bindkey -e
alias find="2> >(grep -v 'Permission denied' >&2) find"

source ~/.profile

[ -n "$SDOTDIR" ] || SDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/shell"
[ -n "$ZDOTDIR" ] || ZDOTDIR="${XDG_CONFIG_HOME:-HOME/.config}/zsh"
[ -n "$CD_HISTFILE" ] || CD_HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/cd_history"
[ -n "$OPEN_HISTFILE" ] || OPEN_HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/open_history"

source "${PREFIX:-/usr}/share/fzf/completion.zsh"
source "$ZDOTDIR/command-tools.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

setopt correct  # Auto correct mistakes
setopt extended_glob  # Allows using regular expressions with *
setopt rc_expand_param  # Array expension with parameters
setopt no_check_jobs  # Don't warn about running processes when exiting
setopt rm_star_silent  # Don't warn when using glob with rm
setopt numeric_glob_sort  # Sort filenames numerically when it makes sense
setopt no_beep  # No beep
setopt append_history  # Immediately append history instead of overwriting
setopt extended_history  # Add timestamps to history
setopt hist_ignore_all_dups  # If a new command is a duplicate, remove the older one
setopt auto_cd  # if only directory path is entered, cd there.
setopt auto_pushd  # pushd on cd
setopt pushd_ignore_dups  # truncate duplicate directories
setopt pushd_minus
setopt interactive_comments  # enable comments on the command line
setopt histignorespace  # ignore lines starting with a space

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$fg[red]%}]%{$reset_color%}$%b "
#PS1=$'\n'"%B%{$fg[red]%}[%{$fg[green]%}%?%{$fg[red]%}] %{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~"$'\n'"%{$fg[red]%}>%{$reset_color%}%b "
#PS1="%B%{$fg[red]%} %~ >%{$fg[yellow]%}%{$reset_color%}%b "
[ -n "$LF_LEVEL" ] && PS1="$PS1(lf: $LF_LEVEL) "

# Change cursor shape for different vi modes.
function zle-keymap-select {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() { echo -ne "\e[5 q"; }
zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Completion.
autoload -Uz compinit
compinit -d ~/.cache/zshcompdump-$ZSH_VERSION
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'       # Case insensitive tab completion
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

unset WORDCHARS
stty -ixon

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-end-of-line vi-add-eol)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char vi-forward-char)

HISTFILE="${XDG_STATE_HOME:=$HOME/.local/state}/zsh/history"
HISTSIZE=100000
SAVEHIST=50000

# source "$ZDOTDIR/completion/arduino-cli.zsh"

# Angular
# _ng_yargs_completions()
# {
#   local reply
#   local si=$IFS
#   IFS=$'
# ' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" ng --get-yargs-completions "${words[@]}"))
#   IFS=$si
#   _describe 'values' reply
# }
# compdef _ng_yargs_completions ng


[ -n "$DISPLAY" ] && command -V xdotool >/dev/null && {
	TERMINAL_WINDOW_ID="$(xdotool getactivewindow)"
	function set_win_title() {
			echo -ne "\033]0; $USER@$HOST:${PWD/$HOME/~} \007"
	}
	precmd_functions+=(set_win_title)
}

_command_fail_hook() {
	[ $? = 1 ] || return
	if [ -n "$TMUX" ]; then
		tmux send-keys C-p
	elif [ -n "$TERMINAL_WINDOW_ID" ]; then
		xdotool key --window "$TERMINAL_WINDOW_ID" ctrl+p
	fi
}
add-zsh-hook precmd _command_fail_hook

_cd_history_hook() {
	sed -i "\|^$PWD$|d" "$CD_HISTFILE"
	echo "$PWD" >> "$CD_HISTFILE"
}
add-zsh-hook -Uz chpwd _cd_history_hook


autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -s '^[o' '^[q lfcd^M'
bindkey -s '^[j' '^[q lfcd "$(ff)"^M'
bindkey -s '^[l' '^[q l^M'
bindkey -s '^[L' '^[q lsblk^M'
bindkey -s '^[D' '^[q dirs -v^M'
bindkey -s '^[i' '^[q pushd -1^M'
bindkey -s '^[-' '^[q cd -^M'
bindkey -s '^[B' '^[q bindkey | less^M'

bindkey jk vi-cmd-mode
bindkey "^j"  autosuggest-execute
bindkey '^P'  up-line-or-beginning-search
bindkey '^N'  down-line-or-beginning-search
bindkey '^[p' up-line-or-history
bindkey '^[n' down-line-or-history
bindkey '^[w' backward-kill-word

autoload -U edit-command-line; zle -N edit-command-line
bindkey '^[E' edit-command-line

typeset -g -A key
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


[ -f "$BUFFER_CACHE" ] && {
	{
		if [ -n "$TMUX" ]; then
			tmux send-keys -l "$(cat "$BUFFER_CACHE")"
		elif [ -z "$TERMUX_VERSION" ]; then
			xdotool type --window "$TERMINAL_WINDOW_ID" "$(cat "$BUFFER_CACHE")"
		fi
		rm -f "$BUFFER_CACHE"
	} & disown
}

export BUFFER_CACHE="${ZCACHEDIR:=$HOME/.cache/zsh}/previous-command-buffer-$$.tmp"
_exec-zsh() {
	echo "$BUFFER" > "$BUFFER_CACHE"
	BUFFER=' exec zsh'
	zle accept-line
}
zle     -N    exec-zsh _exec-zsh
bindkey '^[r' exec-zsh

backward-delete-word-to-slash() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N backward-delete-word-to-slash
bindkey '^W' backward-delete-word-to-slash

_fzf-file-history() {
  LBUFFER="${LBUFFER}$(sed "s|$HOME|~|" "$OPEN_HISTFILE" | fzf --tac --reverse --height 40% | sed "s/ /\\\ /")"
  zle reset-prompt
}
zle     -N   fzf-file-history _fzf-file-history
bindkey '^T' fzf-file-history

_fzf-cd-widget() {
	cdpath="$(eval "${FZF_CD_COMMAND:-find -L . -type d ! -wholename '*.git*' -printf '%p/\n'}" |
		FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse --height 40% $FZF_CD_OPTS" fzf |
		sed 's/"/\\\"/')"
	[ -z "$cdpath" ] && { zle reset-prompt; return; }
	zle push-line
	BUFFER="cd -- \"$cdpath\""
	zle reset-prompt
	zle accept-line
}
zle     -N   fzf-cd-widget _fzf-cd-widget
bindkey '^[c' fzf-cd-widget

_cd-path-history() {
	FZF_CD_COMMAND="< $CD_HISTFILE" \
		FZF_CD_OPTS="--tac --tiebreak=index --no-sort" \
			zle fzf-cd-widget
}
zle     -N    cd-path-history _cd-path-history
bindkey '^[k' cd-path-history

_fzf-history-widget() {
	zle vi-fetch-history -n "$(fc -rl 1 | fzf --height 40% -n2.. --tiebreak=index \
		--preview 'echo {2..}' --preview-window up:50%:hidden:wrap \
		--bind 'ctrl-y:execute-silent(echo -n {2..} | xsel --clipboard)' \
		--query="$LBUFFER")"
	zle reset-prompt
}
zle     -N   fzf-history-widget _fzf-history-widget
bindkey '^R' fzf-history-widget


get-help() {
	[ "$1" != sudo ] && cmd="$1" || cmd="$2"
	cmdinfo="$(command -v "$cmd")"
	case "${$(whence -w "$cmd")##*: }" in
		builtin) MANPAGER="less +/'^       $cmd'" man zshbuiltins && HELP_FOUND=1 ;;
		reserved) MANPAGER="less +/'^reserved' +/'$cmd'" man zshall && HELP_FOUND=1 ;;
		alias) echo "$cmdinfo"; cmd="$(alias "$cmd" | sed "s/$cmd='\(\S*\) .*'/\1/")" ;;
	esac
	[ -n "$cmdinfo" ] && help "$cmd" || help "$1"
}
alias run-help='get-help'
alias which-command='where'

_get-help() {
	cmd=(${=BUFFER})
	zle push-line
	# case "${cmd[1]}" in
	# 	docker|gh|hugo|npm|git|pip) BUFFER="help ${cmd[1]}-${cmd[2]}" ;;
	# 	*) BUFFER="get-help $cmd" ;;
	# esac
	BUFFER="help ${cmd[1]}-${cmd[2]}"
	zle accept-line
}
zle -N get-help _get-help
bindkey '^[H' get-help


[ -f "$SDOTDIR/aliasrc" ] && source "$SDOTDIR/aliasrc"
[ -f "$SDOTDIR/shortcutrc" ] && source "$SDOTDIR/shortcutrc"
[ -f "$SDOTDIR/shortcutenvrc" ] && source "$SDOTDIR/shortcutenvrc"
[ -f "$ZDOTDIR/zshnameddirrc" ] && source "$ZDOTDIR/zshnameddirrc"


case "$TERM" in *256*)

	command -v eza >/dev/null && {
		export IGNORE_GLOB="$(tr '\n' '|' < "$XDG_CONFIG_HOME/fd/ignore")"
		alias l='eza -aF --group-directories-first --color=always --icons'
		alias ll='l -l'
		alias lr='l -R -I "$IGNORE_GLOB"'
		lt() { eza --group-directories-first --color=always \
			--icons=always -aTF -I "$IGNORE_GLOB" "$@" | less -rF; }
	}

	command -v fd >/dev/null && {
		FZF_DEFAULT_COMMAND="fd --hidden --color=always"
		FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --ansi"
		alias f='fd --hidden --no-ignore-vcs'
		alias sr='fd --no-ignore-vcs --color=always . ~/.config ~/.local/bin ~/bin | fzf --ansi'
	}

	command -v starship >/dev/null && {
		eval "$(starship init zsh)"
	}

;; esac

alias s='sudo '
alias p='pacman'
alias sp='sudo pacman'
alias sv='sudo sv'
alias pm='PASSWORD_STORE_DIR=$CUSTOM_PASSWORD_STORE pass'
alias mmv='noglob zmv -W'
alias ide='nvim -u "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/coc.vim"'
alias mirror='sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist-arch'
alias mirrord='sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist-arch'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias fixpacman='sudo rm /var/lib/pacman/db.lck'
alias gtypist="gtypist $GTYPIST_OPTS"
alias typ='launch-gtypist -l "$(sed "/^gtypist lesson - \(.*\)$/!d; s//\1/" ~/Documents/Notes/QuickNote.md)"'
alias typa='launch-gtypist -e 3 -l "$(sed "/^gtypist lesson - \(.*\)$/!d; s//\1/" ~/Documents/Notes/ak47.txt)"'
alias uc='cd ~ && gitpush'  # update config
alias gpu='gitpush'
alias wtr='less -r /tmp/wttr.in'

# Launch new (W)indow in background
new_window() {
	windowid="$(xdotool getactivewindow)"
	setsid -f $TERMINAL -e sh -c "${*:-$SHELL}" >/dev/null 2>&1
	while [ "$(xdotool getactivewindow)" = "$windowid" ]; do sleep 0.1; done
	xdotool windowfocus "$windowid"
}
alias W='new_window '

# Find command package
F() {
	ret=$?
	[ -n "$1" ] && { pacman -F "$@"; return; }
	[ "$ret" != 127 ] && echo "Return code of last command is not 127" >&2 && return 2
	pacman -F "$(fc -s 2>&1 | tail -1 | cut -d\  -f5-)"
}

# Execute functions with sudo
# sudofu() {
#   [[ "$(type -w $1)" == "$1: function" ]] &&
#     ARGS="$@" && sudo bash -c "$(declare -f $1); $ARGS"
# }
# alias ssudo='sudofu '

pyenvs() {
	if [ "$PYENV_VIRTUALENV_INIT" != 1 ]; then
		[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init - zsh)"
		eval "$(pyenv virtualenv-init -)"
	fi
	pyenv activate "$1"
}

# Load syntax highlighter; should be last.
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

