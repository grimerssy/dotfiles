alias nv="nvim"
alias lg="lazygit"
alias tm="tmux"
alias clr="clear"

if [[ $TERM == "xterm-kitty" ]]; then
  alias ssh="kitty +kitten ssh"
fi

case "$(uname -s)" in

Darwin)
	alias ls="ls -G"
	;;

Linux)
	alias ls="ls --color=auto"
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	;;
*)
	;;
esac
