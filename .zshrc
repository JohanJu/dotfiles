HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt RM_STAR_SILENT
bindkey \^U backward-kill-line

source ~/.zsh_alias

if [ -f ~/.zsh_local ]; then
  source ~/.zsh_local
fi

git_info() {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="$(git branch 2> /dev/null | awk '/^\*/ { print $2 }')"
  local untracked_files="Untracked files:"
  local not_staged="Changes not staged for commit:"
  local staged="Changes to be committed:"
  local ahead="Your branch is ahead of"
  local behind="Your branch is behind"

  local msg="%F{blue}$on_branch"
  if [[ $git_status =~ $untracked_files
    || $git_status =~ $not_staged
    || $git_status =~ $staged
    || $git_status =~ $ahead
    || $git_status =~ $behind ]]; then
    msg+=" "
    if [[ $git_status =~ $untracked_files ]]; then
      msg+="%F{white}U"
    fi
    if [[ $git_status =~ $not_staged ]]; then
      msg+="%F{red}N"
    fi
    if [[ $git_status =~ $staged ]]; then
      msg+="%F{green}S"
    fi
  fi
  if [[ $git_status =~ $ahead ]]; then
    msg+="%F{yellow}A"
  fi
  if [[ $git_status =~ $behind ]]; then
    msg+="%F{yellow}B"
  fi
  echo -e "%B$msg%b"
}

autoload -U colors
colors
setopt prompt_subst
PROMPT='%F{yellow}%0~%f% %(#~%F{red}#~%F{green}$)%f '
RPROMPT='$(git_info)%b %F{green}%m%f'
if type "kubectl" > /dev/null; then
  source <(kubectl completion zsh)
fi
if [[ $TILIX_ID ]]; then
  source "/etc/profile.d/vte-2.91.sh"
fi
