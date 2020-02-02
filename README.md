# dotfiles
My custom dotfiles.

To get this going, go through the following steps:
- Launch zsh via `zsh`
- Clone prezto `git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"`
- Run the following to link prezto default files in your $HOME:
```
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```
- Run the install script in this repo
