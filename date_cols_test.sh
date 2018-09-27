# takes time of day now, converts to number relative to the the number of col numbers in ANSI_cols_by_hue
# Intention is that it is used by bash_profile in prompt to colour an element by the time of day
# ANSI_cols_by_hue was derived by finding all the ANSI 256 colours that have 100 sat and 50 l in HSL and sorting by hue.
col_file=~/.dotfiles/ANSI_cols_by_hue

raw_date_fmt="%Y%m%d"
raw_date_time_fmt="%Y%m%d%H%M%S"
sec_fmt="%s"
day_secs="86400"
n_incs="29" # 30 lines (0-29)
conv_fact=$(echo "scale=6;$n_incs/$day_secs" | bc)

date_col_parse()
{
	date_now=$(date +${raw_date_fmt})
	secs_now=$(date +"%s")

	# Adds zeros, presuming raw_date_time_fmt
	date_start="${date_now}000000"

	secs_start=$(date -j -f ${raw_date_time_fmt} $date_start +"%s")

	day_in_inc=$(printf "%0.0f" $(echo "(($secs_now-$secs_start)*($conv_fact))+1" | bc) )

	# echo $day_in_inc

	# Sed and print line from file
	echo $(sed -n "${day_in_inc}p" $col_file)
	# echo "$date_start"



}

# date_col_parse