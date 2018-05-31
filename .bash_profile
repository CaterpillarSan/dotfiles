# bash_profile

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  new="new"
  ID="$new:
$ID"
  ID="`echo "$ID" | fzf | cut -d: -f1`"
  echo "$ID"
  if [[ $ID = $new ]]; then
	cd ~/Desktop
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID" -d
  else
    :  # Start terminal normally
  fi
fi


