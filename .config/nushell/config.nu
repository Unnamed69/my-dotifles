# config.nu
#
# Installed by:
# version  =  "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
source ~/.zoxide.nu
source ~/.cache/carapace/init.nu

# Basic aliases
alias c = clear
alias cp = ^cp -v
alias rm = ^rm -I
alias mv = ^mv -iv
alias ln = ^ln -sriv
alias xclip = ^xclip -selection c
alias pip = pip3
alias python = python3

# Check commands existence and create conditional aliases
def has_command [cmd: string] {
    (which $cmd | is-empty) == false
}

# Tmux function
def tmuxstart [] {
    if (tmux a -t main | complete | get exit_code) == 0 { 
        tmux a -t main 
    } else { 
        tmux new -s main 
    }
}

# Show plain help text for a command
def help_text [cmd: string] {
    run-external $cmd --help | bat --language=help --style=plain
}

if (has_command vim) {
    alias vi = nvim
    alias vim = nvim
}

if (has_command neofetch) {
    alias neofetch = ^fastfetch -c ~/.config/fastfetch/10.jsonc
}

# Colorize commands
alias grep = ^grep --color=auto
alias fgrep = ^fgrep --color=auto
alias egrep = ^egrep --color=auto
alias diff = ^diff --color=auto
alias ip = ^ip --color=auto
alias pacman = ^pacman --color=auto

# LS & TREE
alias ll = ls -l
alias la = ls -la
alias l = ls
alias ols = ^eza -la --group-directories-first --icons=always
alias tree = ^eza --tree --level=5 --icons=always
alias oll = ols -la
alias ola = ols -A
alias ol = ols -F
alias cat = bat
alias less = bat

if (has_command bpytop) { alias top = bpytop }
if (has_command curl) { alias curl = curlie }

# Docker aliases
def dockerrm [] {
    docker ps -qa | xargs docker rm
}

def dockerstop [] {
    docker ps -qa | xargs docker stop
}

def startmongodb [] {
    docker run -p 27017:27017 -v ~/mongodb-data:/data/db -d mongo --name mongodb
}

def startredis [] {
    docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
}

def startmysql [] {
    docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysql -d mysql
}

def startpgsql [] {
    docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres
}

def dcu [] {
    docker compose up -d
}

def dcd [] {
    docker compose down
}

def dl [] {
    docker logs -f
}

## Git and other tools
def gsyncbranch [] {
    git fetch --prune
    git branch -vv | lines | find ": gone]" | str replace --regex "^\\s*([^\\s]+).*$" "$1" | xargs git branch -D
} 
alias ldocker = lazydocker
def lpodman [] {
    let cmd = "DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker"
    ^bash -c $cmd
}
alias fmake = fzf-make
alias k = kubectl

