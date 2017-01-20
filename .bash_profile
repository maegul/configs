# for using het conda installation
#VIRTUAL_ENV_DISABLE_PROMPT=1 source /Users/errollloyd/Library/Enthought/Canopy_64bit/User/bin/activate

# added by Anaconda 1.8.0 installer
export PATH="/Users/errollloyd/anaconda/bin:$PATH"

# Adds my personal script library to pythonpath
export PYTHONPATH=${PYTHONPATH}:~/Dropbox/Science/scripts/

# Edits prompt
export PS1="\n(\!)-(\[\e[37m\]\t\[\e[0m\])-(\[\e[31m\]\u\[\e[0m\])-(\[\e[36m\]\w\[\e[0m\])\n> "

# Add another directory to path, for MRI analysis software
export PATH=$PATH:~/abin

# ??? --- Don't know what this is about, I didn't do it ...
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:~/abin


export PATH=/Applications/NEURON-7.4/nrn/x86_64/bin:$PATH #added by NEURON installer
export PYTHONPATH=${PYTHONPATH}:/Applications/NEURON-7.4/nrn/lib/python #added by NEURON installer
export PYTHONHOME="/Users/errollloyd/anaconda" #added by NEURON installer
export LD_LIBRARY_PATH="/Users/errollloyd/anaconda/lib:$LD_LIBRARY_PATH" #added by NEURON installer


# Add personal executables in $HOME/bin to path

export PATH="$HOME/bin:$PATH"



# Some alias play ... yay!
alias ll='ls -la'


# for viewing man pages in vim
vman() {
	vim -c "SuperMan $*"

	if [ "$?" != "0" ]; then
		echo "No manual entry for $*"
	fi
}


