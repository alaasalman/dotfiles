# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

#export WORKON_HOME=~/.virtualenvs
export SHELL=/bin/zsh
export PATH=$PATH:$HOME/.local/bin

# pipenv completion
# check if pipenv exists before loading completions
if type "pipenv" > /dev/null; then
    eval "$(pipenv --completion)"
fi

# add snap binaries via emulation
emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'
