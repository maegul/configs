
source ~/.bashrc


# > pyenv
# Put here again as well as in .bashrc (on advice from the documentation)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init - bash)"

