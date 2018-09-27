# goes through cols in ANSI_cols_by_hue, prints a space for each, and makrs current time
# relies on the date_cols script in dot files and the ANSI_cols_by_hue file

# this script is in the path
source date_cols_test.sh

cols=$(cat ~/.dotfiles/ANSI_cols_by_hue)
current_time_idx=$(date_col_parse)

# at symbol uses the IFS which presumes separator of a space
for c in ${cols[@]}; do
	if [ "$c" == "$current_time_idx" ]; then
		printf "$(tput sgr0)$(tput setaf $c)*"
	else
		printf "$(tput rev)$(tput setaf $c) "
			
	fi
done

# to reset things for the rest of the prompt
echo $(tput sgr0)
