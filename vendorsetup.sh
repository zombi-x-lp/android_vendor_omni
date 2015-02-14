for combo in $(cat vendor/zombi/zombitargets | awk {'print $1'})
do
    add_lunch_combo $combo
done
