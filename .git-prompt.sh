# bash/zsh git prompt support
#
# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
# Distributed under the GNU General Public License, version 2.0.
#
# This script allows you to see repository status in your prompt.
#
# To enable:
#
#    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
#    2) Add the following line to your .bashrc/.zshrc:
#        source ~/.git-prompt.sh
#    3a) Change your PS1 to call __git_ps1 as
#        command-substitution:
#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#        ZSH:  setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
#        the optional argument will be used as format string.
#    3b) Alternatively, for a slightly faster prompt, __git_ps1 can
#        be used for PROMPT_COMMAND in Bash or for precmd() in Zsh
#        with two parameters, <pre> and <post>, which are strings
#        you would put in $PS1 before and after the status string
#        generated by the git-prompt machinery.  e.g.
#        Bash: PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
#          will show username, at-sign, host, colon, cwd, then
#          various status string, followed by dollar and SP, as
#          your prompt.
#        ZSH:  precmd () { __git_ps1 "%n" ":%~$ " "|%s" }
#          will show username, pipe, then various status string,
#          followed by colon, cwd, dollar and SP, as your prompt.
#        Optionally, you can supply a third argument with a printf
#        format string to finetune the output of the branch status
#
# The repository status will be displayed only if you are currently in a
# git repository. The %s token is the placeholder for the shown status.
#
# The prompt status always includes the current branch name.
#
#####
# Personal changes to symbols being used
#####
#
# Defaults
#
# sym_untracked="%"
# sym_unstaged="*"
# sym_staged="+"
# sym_stashed="$"
# sym_ahead_upstream=">"
# sym_behind_upstream="<"
# sym_equal_upstream="="
# sym_diverged_upstream="<>"
# sym_init_commit="#"
#
# Custom
#

# sym_untracked=$(echo -e "\xce\x9e") # XI for x in greek
# sym_unstaged=$(echo -e "\xce\x94") # DELTA for change in greek
# sym_staged=$(echo -e "\xe0\xa4\x95") # KA for commit in devanagari
# sym_stashed=$(echo -e "\xe0\xa4\xb7") # SA for stash in devanagari
# sym_ahead_upstream=$(echo -e "\xf0\x9f\x9c\x81") # AIR in alchemy for push to cloud
# sym_behind_upstream=$(echo -e "\xf0\x9f\x9c\x83") # EARTH in alchemy for pull down from cloud
# sym_equal_upstream=$(echo -e "\xe2\xa8\x80") # Sun, circle, everything is centered??
# sym_diverged_upstream=$(echo -e "\xe2\xa8\x82") # Cross for divergence
# sym_init_commit=$(echo -e "\xe0\xa4\x8f")sym_untracked=$(echo -e "\xce\x9e") # XI for x in greek

sym_untracked=$(echo -e "\xf0\x9f\x95\xb8\x20") # Spider web
sym_unstaged=$(echo -e "\xf0\x9f\x90\x9b\x20") # Caterpiller for new comings
sym_staged=$(echo -e "\xf0\x9f\xa6\x8b\x20") # Butterfly for new life ready to fly away
sym_stashed=$(echo -e "\xf0\x9f\x92\xb0\x20") # dollar bag for my stash
sym_no_upstream=$(echo -e " ⚫️") # Black circle signifying an absence of a remote
# sym_no_upstream=$(echo -e " \xe2\x9a\xab️") # Black circle signifying an absence of a remote
sym_ahead_upstream=$(echo -e "\xf0\x9f\x8c\x8f\x20") # Earth for new things are on the ground
sym_behind_upstream=$(echo -e "\xf0\x9f\x8c\xa7\x20") # Raining cloud for a pull and merge to come
sym_equal_upstream=$(echo -e "🌈 ") # Rainbow for everything is good
# sym_equal_upstream=$(echo -e "\xf0\x9f\x8c\x88\x20") # Rainbow for everything is good
sym_diverged_upstream=$(echo -e "\xf0\x9f\x92\xa9\x20") # Shit show for it is now a shit show
sym_init_commit=$(echo -e "\xf0\x9f\x8d\x84\x20") # Mushroom for all the new files or spores to be added

sym_branch_has_commits=""
sym_branch_has_no_commits="😑"

__branch_has_commits() {
	local branch_name
	local n_lines

	branch_name="$(git rev-parse --abbrev-ref HEAD)"
	n_lines="$(git show-branch | grep -c $branch_name)"

	if [ "$n_lines" -gt 1 ]; then
		echo "$sym_branch_has_commits"
	else
		echo "$sym_branch_has_no_commits"
	fi
}


# In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
# unstaged (*) and staged (+) changes will be shown next to the branch
# name.  You can configure this per-repository with the
# bash.showDirtyState variable, which defaults to true once
# GIT_PS1_SHOWDIRTYSTATE is enabled.
#
# You can also see if currently something is stashed, by setting
# GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
# then a '$' will be shown next to the branch name.
#
# If you would like to see if there're untracked files, then you can set
# GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
# files, then a '%' will be shown next to the branch name.  You can
# configure this per-repository with the bash.showUntrackedFiles
# variable, which defaults to true once GIT_PS1_SHOWUNTRACKEDFILES is
# enabled.
#
# If you would like to see the difference between HEAD and its upstream,
# set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
# indicates you are ahead, "<>" indicates you have diverged and "="
# indicates that there is no difference. You can further control
# behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
# of values:
#
#     verbose       show number of commits ahead/behind (+/-) upstream
#     name          if verbose, then also show the upstream abbrev name
#     legacy        don't use the '--count' option available in recent
#                   versions of git-rev-list
#     git           always compare HEAD to @{upstream}
#     svn           always compare HEAD to your SVN upstream
#
# You can change the separator between the branch name and the above
# state symbols by setting GIT_PS1_STATESEPARATOR. The default separator
# is SP.
#
# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
# find one, or @{upstream} otherwise.  Once you have set
# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
# setting the bash.showUpstream config variable.
#
# If you would like to see more information about the identity of
# commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
# to one of these values:
#
#     contains      relative to newer annotated tag (v1.6.3.2~35)
#     branch        relative to newer tag or branch (master~4)
#     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#     tag           relative to any older tag (v1.6.3.1-13-gdd42c2f)
#     default       exactly matching tag
#
# If you would like a colored hint about the current dirty state, set
# GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
# the colored output of "git status -sb" and are available only when
# using __git_ps1 for PROMPT_COMMAND or precmd.
#
# If you would like __git_ps1 to do nothing in the case when the current
# directory is set up to be ignored by git, then set
# GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
# repository level by setting bash.hideIfPwdIgnored to "false".

# check whether printf supports -v
__git_printf_supports_v=
printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1

# stores the divergence from upstream in $p
# used by GIT_PS1_SHOWUPSTREAM
__git_ps1_show_upstream ()
{
	local key value
	local svn_remote svn_url_pattern count n
	local upstream=git legacy="" verbose="" name=""

	svn_remote=()
	# get some config options from git-config
	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
	while read -r key value; do
		case "$key" in
		bash.showupstream)
			GIT_PS1_SHOWUPSTREAM="$value"
			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
				p=""
				return
			fi
			;;
		svn-remote.*.url)
			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
			svn_url_pattern="$svn_url_pattern\\|$value"
			upstream=svn+git # default upstream is SVN if available, else git
			;;
		esac
	done <<< "$output"

	# parse configuration values
	for option in ${GIT_PS1_SHOWUPSTREAM}; do
		case "$option" in
		git|svn) upstream="$option" ;;
		verbose) verbose=1 ;;
		legacy)  legacy=1  ;;
		name)    name=1 ;;
		esac
	done

	# Find our upstream
	case "$upstream" in
	git)    upstream="@{upstream}" ;;
	svn*)
		# get the upstream from the "git-svn-id: ..." in a commit message
		# (git-svn uses essentially the same procedure internally)
		local -a svn_upstream
		svn_upstream=($(git log --first-parent -1 \
					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
			svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
			svn_upstream=${svn_upstream%@*}
			local n_stop="${#svn_remote[@]}"
			for ((n=1; n <= n_stop; n++)); do
				svn_upstream=${svn_upstream#${svn_remote[$n]}}
			done

			if [[ -z "$svn_upstream" ]]; then
				# default branch name for checkouts with no layout:
				upstream=${GIT_SVN_ID:-git-svn}
			else
				upstream=${svn_upstream#/}
			fi
		elif [[ "svn+git" = "$upstream" ]]; then
			upstream="@{upstream}"
		fi
		;;
	esac

	# Find how many commits we are ahead/behind our upstream
	if [[ -z "$legacy" ]]; then
		count="$(git rev-list --count --left-right \
				"$upstream"...HEAD 2>/dev/null)"
	else
		# produce equivalent output to --count for older versions of git
		local commits
		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
		then
			local commit behind=0 ahead=0
			for commit in $commits
			do
				case "$commit" in
				"<"*) ((behind++)) ;;
				*)    ((ahead++))  ;;
				esac
			done
			count="$behind	$ahead"
		else
			count=""
		fi
	fi

	# calculate the result
	if [[ -z "$verbose" ]]; then
		# echo "-z VERBOSE $verbose"
		case "$count" in
		"") # no upstream
			p="$sym_no_upstream $(__branch_has_commits)" ;;
			# p="" ;;
		"0	0") # equal to upstream
			p="$sym_equal_upstream" ;;
		"0	"*) # ahead of upstream
			p="$sym_ahead_upstream" ;;
		*"	0") # behind upstream
			p="$sym_behind_upstream" ;;
		*)	    # diverged from upstream
			p="$sym_diverged_upstream" ;;
		esac
	else
		# echo "not -z VERBOSE $verbose"
		case "$count" in
		"") # no upstream
			p="$sym_no_upstream $(__branch_has_commits)" ;;
			# p="" ;;
		"0	0") # equal to upstream
			p="$sym_equal_upstream" ;;
		"0	"*) # ahead of upstream
			p="$sym_ahead_upstream (+${count#0	})" ;;
		*"	0") # behind upstream
			p="$sym_behind_upstream (-${count%	0})" ;;
		*)	    # diverged from upstream
			p="$sym_diverged_upstream (${count#*	}-${count%	*})" ;;
		# "0	0") # equal to upstream
		# 	p=" u=" ;;
		# "0	"*) # ahead of upstream
		# 	p=" u+${count#0	}" ;;
		# *"	0") # behind upstream
		# 	p=" u-${count%	0}" ;;
		# *)	    # diverged from upstream
		# 	p=" u+${count#*	}-${count%	*}" ;;
		esac
		if [[ -n "$count" && -n "$name" ]]; then
			__git_ps1_upstream_name=$(git rev-parse \
				--abbrev-ref "$upstream" 2>/dev/null)
			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
				p="$p-${__git_ps1_upstream_name}-"
				# p="$p \${__git_ps1_upstream_name}"
			else
				p="$p-${__git_ps1_upstream_name}-"
				# not needed anymore; keep user's
				# environment clean
				unset __git_ps1_upstream_name
			fi
		fi
	fi

}

# Helper function that is meant to be called from __git_ps1.  It
# injects color codes into the appropriate gitstring variables used
# to build a gitstring.
__git_ps1_colorize_gitstring ()
{
	if [[ -n ${ZSH_VERSION-} ]]; then
		local c_red='%F{red}'
		local c_green='%F{green}'
		local c_lblue='%F{blue}'
		local c_clear='%f'
	else
		# Using \[ and \] around colors is necessary to prevent
		# issues with command line editing/browsing/completion!
		local c_red='\[\e[31m\]'
		local c_green='\[\e[32m\]'
		local c_lblue='\[\e[1;34m\]'
		local c_clear='\[\e[0m\]'
	fi
	local bad_color=$c_red
	local ok_color=$c_green
	local flags_color="$c_lblue"

	local branch_color=""
	if [ $detached = no ]; then
		branch_color="$ok_color"
	else
		branch_color="$bad_color"
	fi
	c="$branch_color$c"

	z="$c_clear$z"
	if [ "$w" = "*" ]; then
		w="$bad_color$w"
	fi
	if [ -n "$i" ]; then
		i="$ok_color$i"
	fi
	if [ -n "$s" ]; then
		s="$flags_color$s"
	fi
	if [ -n "$u" ]; then
		u="$bad_color$u"
	fi
	r="$c_clear$r"
}

# Helper function to read the first line of a file into a variable.
# __git_eread requires 2 arguments, the file path and the name of the
# variable, in that order.
__git_eread ()
{
	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
}

# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# when called from PS1 using command substitution
# in this mode it prints text to add to bash PS1 prompt (includes branch name)
#
# __git_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
# when two arguments are given, the first is prepended and the second appended
# to the state string when assigned to PS1.
# The optional third parameter will be used as printf format string to further
# customize the output of the git-status string.
# In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
__git_ps1 ()
{
	# preserve exit status
	local exit=$?
	local pcmode=no
	local detached=no
	local ps1pc_start='\u@\h:\w '
	local ps1pc_end='\$ '
	local printf_format=' (%s)'

	case "$#" in
		2|3)	pcmode=yes
			ps1pc_start="$1"
			ps1pc_end="$2"
			printf_format="${3:-$printf_format}"
			# set PS1 to a plain prompt so that we can
			# simply return early if the prompt should not
			# be decorated
			PS1="$ps1pc_start$ps1pc_end"
		;;
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return $exit
		;;
	esac

	# ps1_expanded:  This variable is set to 'yes' if the shell
	# subjects the value of PS1 to parameter expansion:
	#
	#   * bash does unless the promptvars option is disabled
	#   * zsh does not unless the PROMPT_SUBST option is set
	#   * POSIX shells always do
	#
	# If the shell would expand the contents of PS1 when drawing
	# the prompt, a raw ref name must not be included in PS1.
	# This protects the user from arbitrary code execution via
	# specially crafted ref names.  For example, a ref named
	# 'refs/heads/$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' might cause the
	# shell to execute 'sudo rm -rf /' when the prompt is drawn.
	#
	# Instead, the ref name should be placed in a separate global
	# variable (in the __git_ps1_* namespace to avoid colliding
	# with the user's environment) and that variable should be
	# referenced from PS1.  For example:
	#
	#     __git_ps1_foo=$(do_something_to_get_ref_name)
	#     PS1="...stuff...\${__git_ps1_foo}...stuff..."
	#
	# If the shell does not expand the contents of PS1, the raw
	# ref name must be included in PS1.
	#
	# The value of this variable is only relevant when in pcmode.
	#
	# Assume that the shell follows the POSIX specification and
	# expands PS1 unless determined otherwise.  (This is more
	# likely to be correct if the user has a non-bash, non-zsh
	# shell and safer than the alternative if the assumption is
	# incorrect.)
	#
	local ps1_expanded=yes
	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=no

	local repo_info rev_parse_exit_code
	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
		--is-bare-repository --is-inside-work-tree \
		--short HEAD 2>/dev/null)"
	rev_parse_exit_code="$?"

	if [ -z "$repo_info" ]; then
		return $exit
	fi

	local short_sha=""
	if [ "$rev_parse_exit_code" = "0" ]; then
		short_sha="${repo_info##*$'\n'}"
		repo_info="${repo_info%$'\n'*}"
	fi
	local inside_worktree="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local bare_repo="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local inside_gitdir="${repo_info##*$'\n'}"
	local g="${repo_info%$'\n'*}"

	if [ "true" = "$inside_worktree" ] &&
	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
	   git check-ignore -q .
	then
		return $exit
	fi

	local r=""
	local b=""
	local step=""
	local total=""
	if [ -d "$g/rebase-merge" ]; then
		__git_eread "$g/rebase-merge/head-name" b
		__git_eread "$g/rebase-merge/msgnum" step
		__git_eread "$g/rebase-merge/end" total
		if [ -f "$g/rebase-merge/interactive" ]; then
			r="|REBASE-i"
		else
			r="|REBASE-m"
		fi
	else
		if [ -d "$g/rebase-apply" ]; then
			__git_eread "$g/rebase-apply/next" step
			__git_eread "$g/rebase-apply/last" total
			if [ -f "$g/rebase-apply/rebasing" ]; then
				__git_eread "$g/rebase-apply/head-name" b
				r="|REBASE"
			elif [ -f "$g/rebase-apply/applying" ]; then
				r="|AM"
			else
				r="|AM/REBASE"
			fi
		elif [ -f "$g/MERGE_HEAD" ]; then
			r="|MERGING"
		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
			r="|CHERRY-PICKING"
		elif [ -f "$g/REVERT_HEAD" ]; then
			r="|REVERTING"
		elif [ -f "$g/BISECT_LOG" ]; then
			r="|BISECTING"
		fi

		if [ -n "$b" ]; then
			:
		elif [ -h "$g/HEAD" ]; then
			# symlink symbolic ref
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		else
			local head=""
			if ! __git_eread "$g/HEAD" head; then
				return $exit
			fi
			# is it a symbolic ref?
			b="${head#ref: }"
			if [ "$head" = "$b" ]; then
				detached=yes
				b="$(
				case "${GIT_PS1_DESCRIBE_STYLE-}" in
				(contains)
					git describe --contains HEAD ;;
				(branch)
					git describe --contains --all HEAD ;;
				(tag)
					git describe --tags HEAD ;;
				(describe)
					git describe HEAD ;;
				(* | default)
					git describe --tags --exact-match HEAD ;;
				esac 2>/dev/null)" ||

				b="$short_sha..."
				b="($b)"
			fi
		fi
	fi

	if [ -n "$step" ] && [ -n "$total" ]; then
		r="$r $step/$total"
	fi

	local w=""
	local i=""
	local s=""
	local u=""
	local c=""
	local p=""

	if [ "true" = "$inside_gitdir" ]; then
		if [ "true" = "$bare_repo" ]; then
			c="BARE:"
		else
			b="GIT_DIR!"
		fi
	elif [ "true" = "$inside_worktree" ]; then
		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
		   [ "$(git config --bool bash.showDirtyState)" != "false" ]
		then
			git diff --no-ext-diff --quiet || w="$sym_unstaged"
			git diff --no-ext-diff --cached --quiet || i="$sym_staged"
			if [ -z "$short_sha" ] && [ -z "$i" ]; then
				i="$sym_init_commit"
			fi
		fi
		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
		   git rev-parse --verify --quiet refs/stash >/dev/null
		then
			s="${sym_stashed}"
		fi

		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
		   git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
		then
			u="${sym_untracked}${ZSH_VERSION+%}"
		fi

		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
			__git_ps1_show_upstream
		fi
	fi

	local z="${GIT_PS1_STATESEPARATOR-" "}"

	# NO color option unless in PROMPT_COMMAND mode
	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
		__git_ps1_colorize_gitstring
	fi

	b=${b##refs/heads/}
	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
		__git_ps1_branch_name=$b
		b="\${__git_ps1_branch_name}"
	fi

	# local f="$w$i$s$u"
	local f="$u$w$i$s"
	local gitstring="$c$b${f:+$z$f}$r$p"

	if [ $pcmode = yes ]; then
		if [ "${__git_printf_supports_v-}" != yes ]; then
			gitstring=$(printf -- "$printf_format" "$gitstring")
		else
			printf -v gitstring -- "$printf_format" "$gitstring"
		fi
		PS1="$ps1pc_start$gitstring$ps1pc_end"
	else
		printf -- "$printf_format" "$gitstring"
	fi

	return $exit
}
