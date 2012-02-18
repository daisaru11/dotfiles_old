## Default shell configuration
#
# set prompt

#################################################
# プロンプト表示フォーマット
# http://zsh.sourceforge.net/Doc/Release/zsh_12.html#SEC40
#################################################
# %% %を表示
# %) )を表示
# %l 端末名省略形
# %M ホスト名(FQDN)
# %m ホスト名(サブドメイン)
# %n ユーザー名
# %y 端末名
# %# rootなら#、他は%を表示
# %? 直前に実行したコマンドの結果コード
# %d ワーキングディレクトリ %/ でも可
# %~ ホームディレクトリからのパス
# %h ヒストリ番号 %! でも可
# %a The observed action, i.e. "logged on" or "logged off".
# %S (%s) 反転モードの開始/終了 %S abc %s とするとabcが反転
# %U (%u) 下線モードの開始/終了 %U abc %u とするとabcに下線
# %B (%b) 強調モードの開始/終了 %B abc %b とするとabcを強調
# %t 時刻表示(12時間単位、午前/午後つき) %@ でも可
# %T 時刻表示(24時間表示)
# %* 時刻表示(24時間表示秒付き)
# %w 日表示(dd) 日本語だと 曜日 日
# %W 年月日表示(mm/dd/yy)
# %D 年月日表示(yy-mm-dd)

autoload colors
colors
DEFAULT=$'%{\e[1;0m%}'
RESET="%{${reset_color}%}"
#GREEN=$'%{\e[1;32m%}'
GREEN="%{${fg[green]}%}"
#BLUE=$'%{\e[1;35m%}'
BLUE="%{${fg[blue]}%}"
RED="%{${fg[red]}%}"
CYAN="%{${fg[cyan]}%}"
MAGENTA="%{${fg[magenta]}%}"
YELLOW="%{${fg[yellow]}%}"
WHITE="%{${fg[white]}%}"
setopt prompt_subst
case ${UID} in
0)
	#ROOT
	PROMPT="[${BLUE}%n@%m${RESET}] ${BLUE}#${RESET} "
	PROMPT2="%B${BLUE}%_#${RESET}%b "
	SPROMPT="%B${BLUE}%r is correct? [n,y,a,e]:${RESET}%b "
	RPROMPT="${BLUE}[%/]${RESET}"
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="${CYAN}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
	;;
*)
	#USER
	PROMPT='${RESET}${GREEN}${WINDOW:+"[$WINDOW]"}${RESET}%% %{$fg_bold[green]%}%n@%m ${RESET}in ${YELLOW}%(5~,%-2~/.../%2~,%~)% ${RESET} :
${WHITE}$ ${RESET}'
	RPROMPT='${RESET}${WHITE}[%D %*] ${RESET}'
	SPROMPT="%B${BLUE}%r is correct? [n,y,a,e]:${RESET}%b "
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="${CYAN}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
	PROMPT="
${PROMPT}"
	;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# 無駄な末尾の / を削除する
setopt auto_remove_slash

bindkey -e
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

#unsetopt auto_list
unsetopt menu_complete

##↑Allow Key completion
#
#zstyle ':completion:*:default' menu select true

## Alias configuration
##
## expand aliases before completing
##
setopt complete_aliases     # aliased ls needs if file/dir completions work

# 補完表示を全てする
zstyle ':completion:*' verbose 'yes'
# 補完の機能を拡張
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
# 補完候補で入力された文字でまず補完してみて、補完不可なら大文字小文字を変換して補完する
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} r:|[-_.]=**' '+m:{A-Z}={a-z} r:|[-_.]=**'


alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
	alias ls="ls -G -w"
	;;
linux*)
	alias ls="ls --color"
	;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
	precmd() {
		echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	}
	export LSCOLORS=exfxcxdxbxegedabagacad
	export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors \
	'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
	;;
esac

