# !/bin/sh

for conf in $HOME/.config/zsh/*.zsh; do
  source ${conf}
done

unset conf

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
