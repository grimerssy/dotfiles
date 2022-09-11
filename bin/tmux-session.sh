#!/bin/sh

ZOXIDE_RESULT=$(zoxide query $1)

if [ $# -eq 0 ] || [ -z "$ZOXIDE_RESULT" ]; then
  ZOXIDE_RESULT=$(zoxide query -l | fzf --reverse)
fi

if [ -z "$ZOXIDE_RESULT" ]; then
  exit 0
fi

FOLDER=$(basename $ZOXIDE_RESULT | tr '.' '_')

SESSION=$(tmux list-sessions | grep $FOLDER | awk '{print $1}')
SESSION=${SESSION//:/}

if [ -z "$TMUX" ]; then
  if [ -z "$SESSION" ]; then
    cd $ZOXIDE_RESULT
    tmux new-session -d -s $FOLDER
    tmux send-keys -t "$FOLDER:1" "nvim ." Enter
  fi
  tmux attach -t $SESSION
else
  if [ -z "$SESSION" ]; then
    cd $ZOXIDE_RESULT
    tmux new-session -d -s $FOLDER
    tmux send-keys -t "$FOLDER:1" "nvim ." Enter
    tmux switch-client -t $FOLDER
  else
    tmux switch-client -t $SESSION
  fi
fi