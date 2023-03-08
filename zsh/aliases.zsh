alias clr="clear && neofetch"

alias t="task"
alias v="nvim"
alias l="lazygit"
alias a="tmux attach"
alias s="tmux-session.sh"

alias c="cargo"
alias n="pnpm"
alias nx="pnpx"

alias ns="nix-shell --command zsh"

case "$(uname -s)" in
Darwin)
	alias ls="ls -G"
  alias neofetch="neofetch --ascii ~/.config/neofetch/mac"
	;;
Linux)
	alias ls="ls --color=auto"
  alias neofetch="neofetch --ascii ~/.config/neofetch/linux"
	;;
CYGWIN* | MINGW32* | MSYS* | MINGW*)
	;;
*)
	;;
esac
