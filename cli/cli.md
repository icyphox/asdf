# some cool cli stuff

### digitally shred half an image after it is opened
`inotifywait -e open art.jpg && s=$(stat -c %s art.jpg );h=$(($s/2));r=$((s-h)); dd if=/dev/urandom | grep -a -o -P "[\x01-\xD0]" | tr -d $'\n' | dd of=art.jpg bs=1 seek=$h count=$r`

### flip a table when command ends with non-zero exit
`PROMPT_COMMAND='[ $? -eq 0 ] || printf "(╯°□°）╯︵ ┻━┻\n"'`
