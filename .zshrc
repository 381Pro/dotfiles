#---------------------------------------------------------------------------
export PATH=/usr/local/sbin:/usr/local/bin/:$PATH:~/bin:.

#nihongo
export LANG=ja_JP.UTF-8

# ヒストリの設定
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000000000

autoload -Uz colors
colors

# 補完機能を有効にする
_cache_hosts=(`ruby -ne 'if /^Host\s+(.+)$/; print $1.strip, "\n"; end' ~/.ssh/config`) # ssh,scp用ホスト追加
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補一覧をカラー表示
zstyle ':completion:*' list-colors ''

# 前方一致検索
source ~/.zsh-history-substring-search.zsh
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#setopt AUTO_CD               # ディレクトリ移動時にcdを打たなくても，ディレクトリと解釈できる文字列を打てばcd
#cdpath=(. .. ~ /)            # autocdで参照するディレクトリ
setopt list_packed           # 補完候補を詰めて表示
#setopt share_history         # 同時に起動したzshの間でヒストリを共有
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt print_eight_bit       # 日本語ファイル名等8ビットを通す
setopt extended_glob         # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots              # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt correct               # コマンド訂正
setopt nobeep                # ビープ音を鳴らさない
#setopt IGNOREEOF             # Ctrl+Dでログアウトしてしまうことを防ぐ
setopt hist_ignore_dups      # 重複を記録しない
setopt extended_history      # 開始と終了を記録
setopt autopushd
setopt nonomatch             # ワイルドカードにマッチしない場合はそのまま表示



if [[ `uname -m` == 'arm64' ]]; then
    PR_ARCH="A"
else
    PR_ARCH="X"
fi

#PROMPT='%m:%F{green}%~%f %n %F{yellow}$%f '
PROMPT=`echo $PR_ARCH`'%B[%F{yellow}%m%F{white}:(%F{blue}%j%F{white}):(%F{magenta}%?%F{white}):%F{blue}%c%F{white}]%(?.%F{green}%#.%F{red}%#)%F{white}:%f %b'
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%#: "
#RPROMPT=`uname -m`
#---------------------------------------------------------------------------
# alias
case "$OSTYPE" in
    solaris*) alias ls='ls --color=auto -F' ;;
    darwin*)  alias ls='ls -GF'             ;;
    Linux*)   alias ls='ls --color=auto -F' ;;
esac

alias l='ls'
alias ll='ls -l'
alias la='ls -a'

alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

alias grep='grep --color=auto'
alias s='ssh sshgate'
alias d='ssh paik-host'
alias d1='ssh dl-host1'
alias d3='ssh dl-host3'
alias d4='ssh dl-host4'
alias d5='ssh dl-host5'
alias d6='ssh dl-host6'
alias d7='ssh dl-host7'
alias d8='ssh dl-host8'
alias d9='ssh dl-host9'
alias d10='ssh dl-host10'
alias d11='ssh dl-host11'
alias khi='ssh khi'
alias user='ssh khi10'


alias mkdir='mkdir -p'
# alias a8=autopep8

alias img=imgcat
alias op=open
alias p3=python
alias diff=colordiff

alias cd='(){cd $*;pwd;ls}'
alias e='(){emacs $* &}'
alias cppc='(){g++ -I$HOME/c/include/ $* && ./a.out}'
alias psx='(){ps aux | grep -e "$@" -e USER | grep -v grep}'

alias sgate="ssh -D 12380 sshgate -Nf && scselect Aizu"
alias sdl-host4="ssh -D 12380 dl-host4 -Nf && scselect Aizu"
alias sgatestop="killall ssh && scselect Automatic"
alias connect="ssh -f -N -L localhost:8139:163.143.92.182:139 paik-host && open smb://localhost:8139/share"
#alias sccp="ssh r-sawai@sccp.nowhere.co.jp -i ~/.ssh/sccpkey"
#alias gcc=/usr/local/bin/gcc-9
#alias g++=/usr/local/bin/g++-9
#alias sshstop="kill $(ps aux | grep "ssh -f" | grep -v grep | awk '{ print $2 }')"
#alias weather="say '現在の福島の天気は' `curl -s ja.wttr.in/Fukushima?0 | sed -n 3p | cut -c 31-` 'です'"
alias lprw='lpr -o Duplex=DuplexNoTumble'  #両面印刷
alias rfs='du -skh * .??*|sort -n' #カレントディレクトリ以下の使用量を確認するコマンド
alias rank="cat ~/.zsh_history | awk -F'[:;]' '{print \$4}' | LC_ALL=C  sort |uniq -c|LC_ALL=C sort -nr | less"
alias x86='arch -x86_64 zsh'
alias arm='arch -arm64e zsh'
alias atom=code
alias mediapipe="arch -x86_64 /usr/local/opt/python@3.7/libexec/bin/python"

##settings for extenstion like Windows
alias -s {doc,xls,ppt,docx,xslx,pptx,rtf,html,htm,txt,css,pdf}=open
alias -s {c,cpp,txt}=cat
alias -s {py}=python
alias -s {ipynb}='open -a /Applications/Firefox.app'
alias -s {tgz,lzh,zip,arc,tar,war,zoo,bz2,bz,arj,ear,jar}=file-roller

#コマンドの任意の場所で展開できる
alias -g '...'='../../'
alias -g @g='| grep '
alias -g @l='| less '


#---------------------------------------------------------------------------
# function
#function _ssh {
  #compadd `fgrep 'Host ' ~/.ssh/config | awk '{print $2}' | sort`;
#}
function tm() {
  if [ -n "${1}" ]; then
    tmux attach-session -t ${1} || tmux new-session -s ${1}
  else
    tmux attach-session || tmux new-session
  fi
}
function rank_history(){
  cat ~/.zsh_history |awk 'BEGIN {FS=":"} {print $3}'|awk 'BEGIN {FS=";"} {print $2}'|awk '{print $1}' |LC_ALL=C  sort |uniq -c|LC_ALL=C sort -nr | less
}
function aoj(){
    in=$(mktemp)
    out=$(mktemp)
    output=$(mktemp)
    wget -q https://judgedat.u-aizu.ac.jp/testcases/$3/in -O $in
    wget -q https://judgedat.u-aizu.ac.jp/testcases/$3/out -O $out
    $1 $2 < $in > $output
    diff --left-column -y $out $output
    rm -f $in $out $output
}
function removegomi () {
  find . \( -name '.DS_Store' -or -name '._*' \) -delete -print;
}
#neofetch
#---------------------------------------------------------------------------
# for zoom
alias labmeet="op /Applications/zoom.us.app \"zoommtg://zoom.us/join?action=join&confno=599335477&pwd=RHRTSWRoenh3OFNaV1lKK0JvMy9KQT09&zc=0&mcv=0.92.11227.0929&confid=dXNzPVZLWFZpXzdwbHRCVWdkWW1fTHF4anVZTGVaZXRjU0xQTlJZWnR2S2xXQzBWQXU2Qi1hNk9KZVo4dEJDbS00Q3p2UXNINkg5eUpqR3ZCU1UuS19oMzF1MXVNTDZ6Z0hacyZ0aWQ9YThiNTM2NTcyZTlhNDZkMmIzMmM3OTQyOGU1ZDQyMGImYXBwPWZpcmVmb3g%3D&browser=firefox&t=1594028839708\""
alias gtmeet="op /Applications/zoom.us.app \"zoommtg://zoom.us/join?action=join&confno=3161403061&pwd=aXphbTRIUjE4Z3JiSU5Ya05uTTBLQT09&zc=0&mcv=0.92.11227.0929&confid=dXNzPTQxNlctUFdYZm96ZW9yUC16d2R2OHAxLWszeW1KRDhOeXFrbWJqRnpEZ3VvOGFuaUdjMXYtcWZiU25EZUhnVE1RNlk3SjhZV0JsVGlGUTJFLm9uaVd6aGVqUHRyc2psd3ImdGlkPWE4YjUzNjU3MmU5YTQ2ZDJiMzJjNzk0MjhlNWQ0MjBiJmFwcD1maXJlZm94&browser=firefox&t=1594029087644\""
#---------------------------------------------------------------------------
# for Python
export PYTHONPATH=$PYTHONPATH:$PWD
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"
export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I/usr/local/opt/tcl-tk/include' --with-tcltk-libs='-L/usr/local/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"
#---------------------------------------------------------------------------
# for Iterm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#---------------------------------------------------------------------------

# arm or x86 setting
if [ "$(uname -m)" = "arm64" ]; then
  # brew(arm)
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/bin:$PATH"
  #---------------------------------------------------------------------------
  # anyenv(arm)
  export PATH="/opt/homebrew/bin:$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  #---------------------------------------------------------------------------
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
          . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
      else
          export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
      fi
  fi
  unset __conda_setup
  #  <<< conda initialize <<<
  #---------------------------------------------------------------------------
else
  # brew(x86)
  PATH=/usr/local/bin/:$PATH
  eval "$(/usr/local/bin/brew shellenv)"
  #---------------------------------------------------------------------------
  # pyenv(x86)
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(/usr/local/opt/pyenv/bin/pyenv init -)"
  #---------------------------------------------------------------------------
fi
#---------------------------------------------------------------------------

function compare_result(){
    f1=$(mktemp)
    f2=$(mktemp)
    cat > $f1
    cat > $f2
    paste $f1 $f2 | pbcopy
    rm -f $f1 $f2
}