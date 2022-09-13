bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect "^h" vi-backward-char
bindkey -M menuselect "^k" vi-up-line-or-history
bindkey -M menuselect "^l" vi-forward-char
bindkey -M menuselect "^j" vi-down-line-or-history
bindkey -M menuselect "^[[Z" vi-up-line-or-history
bindkey -v "^?" backward-delete-char

function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne "\e[1 q";;      # block
        viins|main) echo -ne "\e[5 q";; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne "\e[5 q"
preexec() { echo -ne "\e[5 q" ;}
