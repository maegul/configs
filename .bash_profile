# for using het conda installation
#VIRTUAL_ENV_DISABLE_PROMPT=1 source /Users/errollloyd/Library/Enthought/Canopy_64bit/User/bin/activate
export EDITOR=vim
export PATH="$(/Users/errollloyd/.dotfiles/custom_path.sh)"

# > Terminal Settings
# vi mode for bash
set -o vi
# bind escape to k+j
# bind '"kj":"\e"'

# allow forward search with reverse search (C-R)
stty -ixon



# > aws tab-complete
# path to aws-completer
export PATH=/usr/local/aws/bin:$PATH
# assigning completer
complete -C '/usr/local/bin/aws_completer' aws

# for helm@2 (as helm is now on v3, but jupyterHub doesn't support)
# installed via brew
# quick hack that is now probably redundant
# export PATH="/usr/local/opt/helm@2/bin:$PATH"


# export PATH=$PATH:~/abin

# export PATH=/Applications/NEURON-7.4/nrn/x86_64/bin:$PATH #added by NEURON installer

# export PATH="/usr/local/bin:$PATH"

# export PATH="$HOME/bin:$PATH"

# > pythonpath
# Adds my personal script library to pythonpath
export PYTHONPATH=${PYTHONPATH}:~/Dropbox/Science/scripts/
export PYTHONPATH=${PYTHONPATH}:~/Developer/zekell/zekell_sqlite/


# For terminus in sublime text
bind '"\e[1;3C": forward-word'
bind '"\e[1;3D": backward-word'

# > AWS Default (name) profile
# profile should be defined in ~/.aws
export AWS_DEFAULT_PROFILE=maegul_user

###
# > Prompt
###


# >> check interactive
# Checking if interactive, to prepare prompt only for interactive
# Using .bash_profile and .bashrc more appropriately may make this cleaner
if [[ $- == *i* ]]
then

# Edits prompt

#old
#export PS1="\n(\!)-(\[\e[37m\]\t\[\e[0m\])-(\[\e[31m\]\u\[\e[0m\])-(\[\e[36m\]\w\[\e[0m\])\n> "


# USing git-prompt (semi-official)

# >> git prompt settings

source ~/.dotfiles/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
#colors only work if using PROMPT_COMMAND ??
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"


# >> pushd for prompt
# addings a pushd dirs to prompt when more than one in stack
print_dirs(){
	if (($(dirs -v | wc -l) > 1));
	then
		echo -e "\n$(dirs -v | tail -n +2)";
	fi
}

# >> backup check
print_backup_check()
{
	time_since=$(backup_since)
	if [[ $time_since > 1 ]]; then
		echo "(${time_since})"
	fi
}

# >> conda env
# check if in conda env, if so return (env)
# used instead of default conda prompt change
# turned off with conda config --set changeps1 false
print_conda_env()
{
	if [ -n "$CONDA_DEFAULT_ENV" ]; then
		echo "($CONDA_DEFAULT_ENV)"
	fi
}

# > time symbol
# For converting current time to col idx from file
source ~/.dotfiles/date_cols_test.sh
# unicode for a filled sun symbol

time_sun_symbol="\xe2\x98\x80"
time_moon_symbol="\xe2\x98\xbe"

print_time_symbol()
{
	date_now=$(date +"%H")
	if [[ $date_now > 20 && $date_now < 5 ]]; then
		time_symbol=$time_moon_symbol
	else
		time_symbol=$time_sun_symbol
	fi
	echo -e "$(tput setaf $(date_col_parse))${time_symbol} $(tput sgr0)"
}

# > tput and color
# Converts RGB coords (6x6x6) to ASNI color code
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}

# prints the full 6 value deep color palette
function RGBpalette(){

	printf "
	| *--> Blue
	| |
	| v Green
	v
	Red

	NNN -> RGB\n"

	for r in {0..5};
		do for g in {0..5};
			do for b in {0..5};
				do tput setaf $(RGBcolor $r $g $b) && tput rev;
				msg="  $r$g$b  "
				if [ $b == 5 ]; then
					echo "$msg";
				else
					echo -n "$msg";
				fi
			done
		done
	done;
	tput sgr0
}



# >> preddefined colours
# Predefined colors
reset=$(tput sgr0)
bold=$(tput bold)
rev=$(tput rev)
# hist_numberBG=$(tput setab 33)
# hist_number=$(tput setaf 213)
col_BUTime=$(tput setaf 208)
gitPrompt=$(tput setaf $(RGBcolor 3 0 3) )
condaEnvCol=$(tput setaf $(RGBcolor 0 4 1))


# >> Assembling Prompt
PS1="\n"
# PS1+="\$(echo -e '$(tput setaf $(date_col_parse))${time_sun_symbol}$(tput sgr0) ')"
PS1+="\$(print_time_symbol)"
PS1+="\[${bold}\]"
# PS1+="\[${rev}\]"
PS1+="\[${col_BUTime}\]\$(print_backup_check)"
PS1+="\[${condaEnvCol}\]\$(print_conda_env)"
PS1+="\n"
PS1+="\[${gitPrompt}\]\$(__git_ps1 '(%s)')"
PS1+="\[\e[36m\](\w)"
PS1+="\[\e[36;2m\]\$(print_dirs)"
PS1+="\[${reset}\]"
PS1+="\n> "

export PS1

#Old custom git prompt
#parse_git_branch(){ git branch 2>/dev/null | grep '^*' | colrm 1 2;}

#export PS1="\n(\!)-(\[\e[31m\]\u\[\e[0m\])\n(\[\e[36m\]\w\[\e[0m\])-(\[\e[35m\]\$(parse_git_branch)\[\e[0m\])\n> "


# > git autocomplete
# Adds script for git autocomplete
source ~/.dotfiles/.git-completion.bash




# > Terminal Colours

# ANSI escape codes cheat sheet

# 38;5 ... foreground
# 48;5 ... background
# 7 swap background and foreground (useful)
# 1 ... bold
# 4 ... underline

# >> LSColors
export CLICOLOR=1
export LSCOLORS=GaBaBxDxFaegedabagAgAf

# For linux style binaries (translated from LSCOLORS above using https://geoff.greer.fm/lscolors/
#export LS_COLORS='di=1;36;40:ln=1;31;40:so=1;31:pi=1;33:ex=1;35;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=1;30;46:ow=1;30;45'


# >> Exa Colours

# dir_color="di=38;5;$(RGBcolor 0 5 5);1;4;48;5;$(RGBcolor 2 0 1)"
#dir_color="di=38;5;$(RGBcolor 0 0 1);1;48;5;$(RGBcolor 0 3 3)"
dir_color="di=1;7;38;5;$(RGBcolor 0 3 3)"
ex_color="ex=38;5;$(RGBcolor 4 0 2);1;4"
link_color="ln=48;5;$(RGBcolor 1 0 1)"
python_script_color="*.py=38;5;$(RGBcolor 1 4 0);1"
jup_nb_color="*.ipynb=38;5;$(RGBcolor 0 3 1);4"
pkl_color="*.pkl=7;38;5;$(RGBcolor 0 3 2)"
markdown_color="*.md=38;5;$(RGBcolor 4 2 3)"
custom_immediate="38;5;$(RGBcolor 4 4 0);1;4"

current_user_color="uu=38;5;$(RGBcolor 3 2 0);1"
user_r_bit="ur=7;38;5;$(RGBcolor 0 4 0);1" # green
user_w_bit="uw=7;38;5;$(RGBcolor 4 4 0);1" # green
user_x_bit="ux=7;38;5;$(RGBcolor 4 0 0);1" # green
user_xd_bit="ue=7;38;5;$(RGBcolor 4 0 0);1" # green

grp_r_bit="gr=38;5;$(RGBcolor 0 4 0);1" # green
grp_w_bit="gw=38;5;$(RGBcolor 4 4 0);1" # green
grp_x_bit="gx=38;5;$(RGBcolor 4 0 0);1" # green

oth_r_bit="tr=38;5;$(RGBcolor 0 4 0);1" # green
oth_w_bit="tw=38;5;$(RGBcolor 4 4 0);1" # green
oth_x_bit="tx=38;5;$(RGBcolor 4 0 0);1" # green

export LS_COLORS="$link_color:so=1;31:pi=1;33:$ex_color:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=1;30;46:ow=1;30;45:$python_script_color:$jup_nb_color:$dir_color:$pkl_color:$markdown_color:*readme*=$custom_immediate:*README*=$custom_immediate:*.todo=$custom_immediate:*.TODO=$custom_immediate:*thoughts*=$custom_immediate"

# for exa specifically
export EXA_COLORS="$current_user_color:$user_r_bit:$user_w_bit:$user_x_bit:$user_xd_bit:$grp_r_bit:$grp_w_bit:$grp_x_bit:$oth_r_bit:$oth_w_bit:$oth_x_bit"



fi

# Add another directory to path, for MRI analysis software




# ??? --- Don't know what this is about, I didn't do it ...
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:~/abin


# export PYTHONPATH=${PYTHONPATH}:/Applications/NEURON-7.4/nrn/lib/python #added by NEURON installer

# The line below appears unnecessary ... adding anaconda/bin to PATH is sufficient.
# Indeed, the below breaks pip's ability to be environment aware in conda environments
# export PYTHONHOME="/Users/errollloyd/anaconda" #added by NEURON installer

# not sure what this is about or why it's necessary ... my remove
# export LD_LIBRARY_PATH="/Users/errollloyd/anaconda/lib:$LD_LIBRARY_PATH" #added by NEURON installer

# Add User executables to path early so that they override /usr/bin


### this directory should be used by HomeBrew.  It should also be added by path_helper through /etc/paths, but in the wrong order.  I don't want to muck around with /etc/paths, so Im adding it here.  It will probably appear twice in PATH now. :(

# Add personal executables in $HOME/bin to path


# NPM global installs available by require()
export NODE_PATH=/usr/local/lib/node_modules

# shell options

# extglob - more regex options (?)
shopt -s extglob

# > history management
# allow preceding whitespace to prevent from being logged in history
HISTCONTROL=ignorespace

HISTSIZE=5000
HISTFILESIZE=20000

shopt -s histappend


# > Aliases

# >> zekell
alias zkl='/Users/errollloyd/Developer/zekell/zekell_sqlite/zekell.py'

# Some alias play ... yay!

# >> File management ls / exa

# alias ll='ls -haltF'
# --icons (v>=0.9.0) relies on appropriate fonts
# Currently installed through brew tap cask/homebrew-fonts ... hack-nerd-font and drois-sans-mono font
# "g" prints group ... maybe not that valuable on macOS home machine?
alias ll='exa -laFg -s=age --git --icons' # basic long form sorted by age (youngest fist)
alias llt='exa -laFg -s=type --git --icons' # sort by type
alias lltr='exa -laFg --tree --git --icons -I .git' # tree display, ignore .git folders
alias llext='exa -laFg -s=extension --git --icons' # sort by extension

# ranger file, when sourced mangles bash to cd to current directory on exit
# while also running ranger
# so alias simply sources from path whatever ranger is
# which should run ranger and return to ranger's last directory on exit
alias rang='source $(which ranger)'

# CLICOLOR_FORCE for BSD/MAC to force ls to provide color chars in output to non terminal
# alias lls='CLICOLOR_FORCE= ll | less -R'

# tree alias with nicer graphics
alias tree='tree -A'

alias cl='clear'


# >> Diffs

alias gdiff='git diff --no-index --word-diff=color -w'
# alias fulldiff='colordiff -y -W 200 --left-column'

fulldiff() {
	# provide width as third argument!
	colordiff -y -W ${3:-200} --left-column $1 $2 | less -R
}
fulldiff_q() {
	# provide width as third argument!
	colordiff -y -W ${3:-200} --suppress-common-lines $1 $2 | less -R
}




# >> Network

# list listening ports on local host
alias lslocports="netstat -anp tcp \
| awk '/127.0.0.1.*LISTEN.*/ {print \$4}' | awk -F \".\" '{print \$5}' \
| sort -n"


# >> bash profile

# edit and source bash profile
export USER_BASH_PROFILE_PATH='~/.bash_profile'
alias bpe="vim $USER_BASH_PROFILE_PATH"
alias bpes="subl -n $USER_BASH_PROFILE_PATH"
alias bpsrc="source $USER_BASH_PROFILE_PATH"




# python web server (py 2)
# alias py_serve='python -m SimpleHTTPServer'
# python 3 version
alias py_serve='python -m http.server'


# >> python test debug with ipython
alias ptidb='pytest --pdbcls=IPython.terminal.debugger:TerminalPdb --pdb -s'

# spartan SSH
alias spartan_ssh='ssh errol@spartan.hpc.unimelb.edu.au'

alias spartan_ssh_io='ssh errol@spartan-io.hpc.unimelb.edu.au'

# nectar errol-test ssh
alias nectar_ssh='ssh -i ~/.ssh/errolNectarKey2019.pem ubuntu@115.146.86.153'

# mac pro ssh

alias mac_pro_ssh='ssh Errol@errol-mac-pro.mobility.unimelb.net.au'

alias mac_pro_hal_ssh='ssh Hal@errol-mac-pro.mobility.unimelb.net.au'

alias aryabhat_ssh='ssh Aryabhat@10.100.132.149'

alias aws_free_ssh='ssh -i ~/.ssh/id_rsa ubuntu@ec2-13-55-125-43.ap-southeast-2.compute.amazonaws.com'
alias aws_large_ssh='ssh -i ~/.ssh/id_rsa ubuntu@ec2-13-236-177-188.ap-southeast-2.compute.amazonaws.com'

alias ssh_hosts="grep 'Host \S' ~/.ssh/config | cut -c 6-"

# project notes todo check
alias todo='/Users/errollloyd/Dropbox/Science/PhD/project_notes/todo_check.sh'


# matlab no desktop alias

alias matlab_cl='matlab -nodesktop -nodisplay -nosplash'


# get current ip address

alias my_ip='ipconfig getifaddr en0'


# Get 12 character SHA of current git HEAD

alias head_sha='git log --pretty=format:%H -1 | cut -c 1-12'

# >> tmux aliases

alias tm="tmux"

# create new named tmux session
alias tm_new="tmux new -s"

# list sessions
alias tm_ls="tmux ls"

# attach to named session
alias tm_at="tmux a -t"

# kill named session
alias tm_kill="tmux kill-session -t"

# Misc Aliases

# sublime text

alias sublime_press_hold_on='defaults write com.sublimetext.4 ApplePressAndHoldEnabled -bool false'
alias sublime_press_hold_off='defaults write com.sublimetext.4 ApplePressAndHoldEnabled -bool true'

## Go to User folder of current sublime text install
alias goto_sublime_user='cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User'

alias goto_lenTun_data='cd /Volumes/MagellanX/PhD/Data/length_tun_data/'
alias goto_proj_notes='cd ~/Dropbox/Science/PhD/project_notes'

# alias for quick debug
alias qlldb='lldb --batch -o run -o bt -o q'

lls() {
	CLICOLOR_FORCE= ls -haltF $1 | less -R
}

## volume management aliases

# python charmers volume

alias pychm_mount='diskutil apfs unlockVolume /dev/disk1s5'
alias pychm_unmount='diskutil unmount /dev/disk1s5'

alias jnb_ssh='ssh ubuntu@notebooks.pythoncharmers.com'

## Sendong to Python Charmers AWS Notebook Server by scp
# senf file
jnb_send() {
	scp $1 ubuntu@notebooks.pythoncharmers.com:"'/var/www/notebooks/notes/424 Intermediate Best Practices/Errol Lloyd'"
}

# send dir
jnb_send_dir() {
	scp -r $1 ubuntu@notebooks.pythoncharmers.com:"'/var/www/notebooks/notes/424 Intermediate Best Practices/Errol Lloyd'"
}

# >> aws aliases

# take from macOS clipboard and set to awsinst
alias aws_copy_ip='export awsinst=$(pbpaste)'

alias aws_qcon='ssh ubuntu@$(pbpaste)'
alias aws_con='ssh ubuntu@$awsinst'

# assumes default profile is pythoncharmers
alias aws_list_running_ec2="aws ec2 describe-instances --query \"Reservations[*].Instances[*].{public_ip:PublicIpAddress,priv_ip:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}\" --output table --filters \"Name=instance-state-name,Values=running\""


# requires aws CLI configured for users
# also depends on jq

alias aws_li="aws ec2 describe-instances | jq '.Reservations | .[] | .Instances | .[] | {type: .InstanceType, id: .InstanceId, state: .State.Name, tags: .Tags}'"

alias aws_start="aws ec2 start-instances --profile maegul --instance-ids"
alias aws_stop="aws ec2 stop-instances --profile maegul --instance-ids"

# presumes single running instance for easy use
aws_running_id() {
	aws ec2 describe-instances --profile maegul | jq -r '.Reservations | .[] | .Instances | .[] | select(.State.Name=="running") | .InstanceId'
}

# presumes single running instance for easy use
aws_running_dns(){
	aws ec2 describe-instances --profile maegul | jq -r '.Reservations | .[] | .Instances | .[] | select(.State.Name=="running") | .PublicDnsName'
}

# presumes single running instance
alias aws_running_ssh='ssh ubuntu@$(aws_running_dns)'


# for pychm account

alias aws_li_pychm="aws ec2 describe-instances | jq '.Reservations | .[] | .Instances | .[] | {type: .InstanceType, id: .InstanceId, state: .State.Name, tags: .Tags}'"

alias aws_start_pychm="aws ec2 start-instances --instance-ids"
alias aws_stop_pychm="aws ec2 stop-instances --instance-ids"

# couldn't get at command to work ... otherwise code is probably good
# aws_timed_instance() {
# 	aws ec2 start-instances --instance-ids $1
	# echo "aws ec2 stop-instances --instance-ids $1" | at now + 4 hours
# }

# presumes single running instance for easy use
aws_running_id_pychm() {
	aws ec2 describe-instances | jq -r '.Reservations | .[] | .Instances | .[] | select(.State.Name=="running") | .InstanceId'
}

# presumes single running instance for easy use
aws_running_dns_pychm(){
	aws ec2 describe-instances | jq -r '.Reservations | .[] | .Instances | .[] | select(.State.Name=="running") | .PublicDnsName'
}

# presumes single running instance
alias aws_running_ssh_pychm='ssh ubuntu@$(aws_running_dns_pychm)'


## Current transitioning conda env to python 3 ... quickly source

# transition complete(?)
# alias pynew='source activate n3w'

# > Document Tools

# >> markdown to docx
# pandoc function to convert markdown to docx of same filename
md2doc() {
	file=$1
	pandoc $file -o "${file%.*}.docx"
}

# > Git and Version Control


# nicer issue list with hub
alias hil='hub issue -f "%sC%i%Creset %t %n%Cblue%Nc%Creset%Cmagenta(%au)%Creset%Ccyan(%cD, %ur)%Creset %l%n%n"'

# >> Clone and Fork
# Clones and then forks a GitHub repo
# Relies on hub and ack for regex
gh_fork() {
	regex='([\w\d\-]+).git$'
	repo_dir="$(echo $1 | ack $regex --output '$1')"
	# echo $repo_dir
	git clone $1
	cd $repo_dir
	hub fork
}
# trying a better command with better defaults for the hub cli
gh_fork() {
	regex='([\w\d\-]+).git$'
	repo_dir="$(echo $1 | ack $regex --output '$1')"
	# echo $repo_dir
	hub clone $1
	cd $repo_dir
	# now upstream is "upstream" and personal fork is "origin"
	hub fork --remote-name origin
	# set upstream for local pushes to origin (personal remote)
	git --track origin master
}

# for viewing man pages in vim
vman() {
	vim -c "SuperMan $*"

	if [ "$?" != "0" ]; then
		echo "No manual entry for $*"
	fi
}


# > Shell Hacks

# >> quick find

# quick find in current directory
function qfd { find . -iname "*$1*" -print; }


# >> make dir and change dir
# make and change to directory
mkcd()
{
	mkdir -- "$1" &&
		cd -- "$1"
}


# >> Directory Stack
# aliases for pushd stack usage
# alias pcd='pushd'
pcd_re='^[0-9]+$'
pcd()
{
	# If arg is a number, then rotate with + symbol
	if [[ "$1" =~ $pcd_re ]] ; then
		pushd +"$1" > /dev/null
	# Else, push the directory onto the stack
	else
		pushd "$1" > /dev/null
	fi
}
alias dirs='dirs -v'
mkpcd()
{
	mkdir -- "$1" &&
		pcd "$1"
}

# clear with dirs -c
pcl()
{
	if [[ "$1" =~ $pcd_re ]] ; then
		popd +"$1" > /dev/null
	else
		dirs -c
	fi
}


# > conda

alias cna='conda activate'
alias cnda='conda deactivate'
alias cnli='conda env list'

# Open safari window and start jupyter notebook kernel
######
# Requires the window to be refreshed
# Relies on an Apple Script to open a new window with a particular URL
# All of this is necessary just to keep the auto open tab behaviour of safari ... there's probably a better way
function jnb {

	for n in {0..20}
	do let nn=8888+n
		if lsof -Pi :$nn -sTCP:LISTEN -t >/dev/null; then
			echo "$nn already being used";
		else
			osascript ~/Library/Scripts/jnb_saf_open.scpt "http://localhost:$nn"
			jupyter notebook --port=$nn --no-browser
			break
		fi
	done

}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/errollloyd/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/errollloyd/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/errollloyd/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/errollloyd/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# > Kubernetes and Kubectl
# kube plugins
# custom plugins installed with custom install script in repo (currently located in pychm volume)
export PATH=$PATH:~/.kube/plugins/jordanwilson230

# for more standard plugin manager (no sure anything installed yet)
export PATH="${PATH}:${HOME}/.krew/bin"

test_func(){
	echo $1
}

# kb_context(){
# 	kubectl config current-context
# }

# kb_context_list_all(){
# 	# awkwardly, the first column is empty when not current, so first column is col name for not current
# 	kubectl config get-contexts | tail -n +2 | awk '{print ($1 == "*" ? FNR "-> " $2 : FNR "   " $1)}'
# }

# kb_context_get(){
# 	# awkwardly, the first column is empty when not current, so first column is col name for not current
# 	kubectl config get-contexts | tail -n +2 | awk -v x=$1 'FNR == x {print ($1 == "*" ? $2 : $1 )}'
# }

# kb_context_cp(){
# 	kb_context_get $1 | tr -d '\n'| pbcopy
# }

# kb_context_set(){
# 	kubectl config use-context $(kb_context_get $1)
# }

# # set current context to use the provided namespace as default
# kb_context_default_namespace(){
#   kubectl config set-context --current --namespace=$1
# }

# # scale number of replicas to input (~ number of participants)
# kb_scale_replicas(){
# 	kubectl scale -n jhub statefulsets/user-placeholder --replicas=$1
# }

# # sort by ip address
# kb_list_all_pods(){
# 	kubectl get pod -n jhub -o wide | awk 'NR>1{ print $1, $7, $5}' | sort -k 2 | rs _ 3
# }

# # sort by ip address
# kb_list_all_jupyter_pods(){
# 	kubectl get pod -n jhub -o wide | awk '/jupyter/ NR>1{ print $1, $7, $5}' | sort -k 2 | rs _ 3
# }

# # searches pod names for provided string as 'jupyter-.*STRING.*'
# kb_find_pod_name(){
# 	# kubectl get pods | awk -v nm="$1" '/jupyter-.*nm.*/ {print $1}'
# 	kubectl get pods -n jhub | awk -v nm="jupyter-.*$1.*" '$1 ~ nm {print $1}'
# }

# # opens bash terminal on pod provided
# kb_get_pod_shell(){
# 	kubectl exec -it -c notebook -n jhub $1 -- /bin/bash
# }

# # wrapper around find_pod_name and get_pod_shell
# kb_find_pod_shell(){
# 	kb_get_pod_shell $(kb_find_pod_name $1)
# }

# # get root shell
# kb_get_pod_shell_root(){
# 	kubectl ssh -c notebook -n jhub $1 -- /bin/bash
# }

# # run command on all pods
# kb_com_all_pods(){
# 	kubectl get pod -n jhub | awk '/jupyter/ {print $1}' | parallel -I {} kubectl exec -it -c notebook -n jhub {} -- bash -c "$@"
# }

# # run command as root on all pods
# kb_com_root_all_pods(){
# 	kubectl get pod -n jhub | awk '/jupyter/ {print $1}' | parallel -I {} kubectl ssh -c notebook -n jhub {} -- $@

# }

##
# Your previous /Users/errollloyd/.bash_profile file was backed up as /Users/errollloyd/.bash_profile.macports-saved_2021-02-26_at_15:08:36
##

# MacPorts Installer addition on 2021-02-26_at_15:08:36: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

