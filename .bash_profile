# for using het conda installation
#VIRTUAL_ENV_DISABLE_PROMPT=1 source /Users/errollloyd/Library/Enthought/Canopy_64bit/User/bin/activate

# added by Anaconda 1.8.0 installer
export PATH="/Users/errollloyd/anaconda/bin:$PATH"

# Adds my personal script library to pythonpath
export PYTHONPATH=${PYTHONPATH}:~/Dropbox/Science/scripts/

# Edits prompt
#old
#export PS1="\n(\!)-(\[\e[37m\]\t\[\e[0m\])-(\[\e[31m\]\u\[\e[0m\])-(\[\e[36m\]\w\[\e[0m\])\n> "

parse_git_branch(){ git branch 2>/dev/null | grep '^*' | colrm 1 2;}

export PS1="\n(\!)-(\[\e[31m\]\u\[\e[0m\])-(\[\e[36m\]\w\[\e[0m\])-(\[\e[35m\]\$(parse_git_branch)\[\e[0m\])\n> "

# Change terminal colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Add another directory to path, for MRI analysis software
export PATH=$PATH:~/abin

# ??? --- Don't know what this is about, I didn't do it ...
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:~/abin


export PATH=/Applications/NEURON-7.4/nrn/x86_64/bin:$PATH #added by NEURON installer
export PYTHONPATH=${PYTHONPATH}:/Applications/NEURON-7.4/nrn/lib/python #added by NEURON installer

# The line below appears unnecessary ... adding anaconda/bin to PATH is sufficient.
# Indeed, the below breaks pip's ability to be environment aware in conda environments
# export PYTHONHOME="/Users/errollloyd/anaconda" #added by NEURON installer

# not sure what this is about or why it's necessary ... my remove
export LD_LIBRARY_PATH="/Users/errollloyd/anaconda/lib:$LD_LIBRARY_PATH" #added by NEURON installer


# Add personal executables in $HOME/bin to path

export PATH="$HOME/bin:$PATH"

# NPM global installs available by require()
export NODE_PATH=/usr/local/lib/node_modules

# shell options

# extglob - more regex options (?)
shopt -s extglob



# Some alias play ... yay!
alias ll='ls -la'


# for viewing man pages in vim
vman() {
	vim -c "SuperMan $*"

	if [ "$?" != "0" ]; then
		echo "No manual entry for $*"
	fi
}


