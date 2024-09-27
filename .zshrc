# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]] then
	# Install homebrew for linux
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Automatically attach tmux to "main" session
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
  tmux a -t main || exec tmux new -s main && exit;
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light junegunn/fzf-git.sh

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -v
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd --color always $realpath'

# Aliases
alias c='clear'
alias cp='cp -v'
alias rm='rm -I'
alias mv='mv -iv'
alias ln='ln -sriv'
alias xclip='xclip -selection c'
alias pip='pip3'
alias python='python3'
command -v vim > /dev/null && alias vi='nvim'
command -v vim > /dev/null && alias vim='nvim'
command -v neofetch > /dev/null && alias neofetch='fastfetch -c ~/.config/fastfetch/10.jsonc'

### Colorize commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias pacman='pacman --color=auto'
alias tmuxs='tmux a -t main || exec tmux new -s main'

### LS & TREE
alias ll='ls -la'
alias la='ls -A'
alias l='ls -F'
command -v lsd > /dev/null && alias ls='eza -la --group-directories-first --icons=always' && \
	alias tree='eza --tree --level=5 --icons=always'
command -v bat > /dev/null && \
	alias bat='bat --theme=ansi' && \
	alias cat='bat' && \
	alias less='bat'
command -v batcat > /dev/null && \
	alias batcat='batcat --theme=ansi' && \
	alias cat='batcat --pager=never' && \
	alias less='batcat'
command -v bpytop > /dev/null && alias top='bpytop'
command -v df > /dev/null && alias df='duf'
command -v ps > /dev/null && alias ps='procs'
command -v curl > /dev/null && alias curl='curlie'
alias dockerrm='docker rm $(docker ps -qa)'
alias dockerstop='docker stop $(docker ps -qa)'
alias startmongodb='docker run -p 27017:27017 -v ~/mongodb-data:/data/db -d mongo'
alias startredis='docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 redis/redis-stack:latest'
alias startmysql='docker run --name mysql-container -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysql -d mysql'
alias startpgsql='docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres:15'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dl='docker logs -f'
alias gsyncbranch="git fetch --prune && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D"
alias ldocker='lazydocker'
alias lpodman='DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker'
command -v docker-compose > /dev/null && alias docker compose='/usr/bin/docker compose'
alias k='kubectl'
dcuf() {
    docker-compose -f "$1" up -d
}

#__prompt_to_bottom_line() {
#  tput cup $LINES
#}
#alias clear='clear && __prompt_to_bottom_line'
#__prompt_to_bottom_line

# Exports
export PATH=$PATH:$HOME/bin
export PATH=/usr/bin:$PATH
export PATH=$PATH:$HOME/.local/bin
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export PATH=~/.asdf/shims:$PATH
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/FileCentipede/fileu
export PATH=$PATH:$(go env GOPATH)/bin
# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
#
# # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# # - The first argument to the function ($1) is the base path to start traversal
# # - See the source code (completion.{bash,zsh}) for the details.
 _fzf_compgen_path() {
   fd --hidden --exclude .git . "$1"
   }

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
  }
# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"
# --- setup fzf previews ---
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# # - The first argument to the function is the name of the command.
# # - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
		export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
		ssh)          fzf --preview 'dig {}'                   "$@" ;;
		*)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
	esac
}
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export BAT_THEME=tokyonight_night
# Shell integrations
. $HOME/.asdf/asdf.sh
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(gh copilot alias -- zsh)"
eval "$(thefuck --alias)"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
