Rename all files in a directory - add a prefix to their filename

    find . -name '*.log' -exec bash -c 'mv "$1" "$(dirname $1)/interbench-$(basename $1)"' bash "{}" \;

---

Recursively rename all files, directories etc. that contain spaces in their filenames with underscores:

    find . -name '* *' -exec bash -c 'mv "$1" "${1// /_}"' bash "{}" \;

* https://unix.stackexchange.com/questions/172186/find-xargs-and-mv-renaming-files-with-double-quotes-expansion-and-bash-preced/172196#172196
* https://unix.stackexchange.com/questions/389705/understanding-the-exec-option-of-find/389706#389706

---

List all files in a directory recursively sorted by size with largest first

    ls -hl -R -S <folder_name> > <output_file_name>

Rename all files in current directory
- singlify duplicate characters, replace spaces and special characters with another character
- assuming there is no spaces in the path to the current working directory `pwd`

        for file in $(pwd)/*; do mv "$file" "$(echo "$(pwd)/$(basename "${file}")" | sed "s/['´]//g" | sed 's/[() ]/_/g' | sed 's/__/_/g')" ; done

        for file in $(pwd)/*; do mv "$file" "$(echo "${file}" | sed "s/['´]//g" | sed 's/[() ]/_/g' | sed 's/__/_/g')" ; done

Sort files in a directory by the latest modification time `mtime` from newest.
- files are marked as modified with the `touch` command
- `-r` - sort in reverse order, i.e. show the latest modified file first

        ls -l --sort=time -r --time-style="+%D %H:%M" | awk '{ print $6,$7,$8 }'
        ls -l --time-style="+%Y %m %d %H:%M" | awk '{ print $6,$7,$8,$9,$10 }' | sort
        ls -l --time-style="+%Y %m %d %H:%M" *.ogg | awk '{ print $6,$7,$8,$9,$10 }' | sort
        while read -r line; do printf '%s\n' "$line" | tr -s ' ' | cut -d' ' -f6,7,8,9,10; done < <(ls -l --time-style="+%Y %m %d %H:%M") | sort
        
    or use [this script for listing media files sorted by modification time](https://gist.github.com/kyberdrb/28a35fee042c49cb038c1f73f8a25e23).
        

Show length of a media file
- the `2>&1` redirection filters out the details of the output leaving only the duration visible

        ffprobe "MEDIA_FILE_NAME" 2>&1 | awk '/Duration/ { print $2 }' | cut -d',' -f1

Move files to trash

    gio trash FILENAME
    gio list trash://
    gio trash --empty
    # https://wiki.archlinux.org/index.php/Trash_management
    
Copy absolute path of the current working directory

    echo -n "$(pwd)" | xclip -se c

or in complete syntax

    echo -n $(pwd) | xclip -selection clipboard
    
Copy folder name, change all uppercase letters to lowercase and copy it to clipboard

    echo -n $(basename $(pwd) | tr '[:upper:]' '[:lower:]') | xclip -se c

Replace multiple consecutive whitespaces in a filename with one space character and replace all spaces with underscores

    mv "file with spaces" "$(echo 'file with spaces' | tr -s ' ' | sed 's/ /_/g')"
    
Replace whitespaces and special characters

    echo -n text with spaces | sed 's/["]//g' | sed "s/'//g" | sed 's/[:]/_-_/g' | sed 's/[, ]/_/g' | sed 's/;/_-_/g' | tr -s '_' | xclip -se c
    echo -n "text with single quotes' and spaces" | sed 's/["]//g' | sed "s/'//g" | sed 's/[:]/_-_/g' | sed 's/[, ]/_/g' | sed 's/;/_-_/g' | tr -s '_' | xclip -se c
    echo -n text with "double quotes" and spaces | sed 's/["]//g' | sed "s/'//g" | sed 's/[:]/_-_/g' | sed 's/[, ]/_/g' | sed 's/;/_-_/g' | tr -s '_' | xclip -se c

Managing and stopping processes

- Force process to terminate

        kill -9 <PIDs>
        kill -s 9 <PIDs>
        kill - KILL <PIDs>

- Other ways of managing processes

        killall -9 mousepad
        killall -KILL mousepad
        killall -TERM mousepad
        killall -INT mousepad
    
        # https://unix.stackexchange.com/questions/254463/what-does-the-option-9-mean-for-killall
        # https://unix.stackexchange.com/questions/5642/what-if-kill-9-does-not-work/5648#5648
        # Sending and Handling Signals in Linux (kill, signal, sigaction): https://www.youtube.com/watch?v=83M5-NPDeWs

- the `export` command

        $ # Illustrating how 'export' command works
        $ # 
        $ # Sources:
        $ # https://stackoverflow.com/questions/1158091/defining-a-variable-with-or-without-export
        $ # https://stackoverflow.com/questions/1158091/defining-a-variable-with-or-without-export/1158231#1158231
        $ # https://stackoverflow.com/questions/1158091/defining-a-variable-with-or-without-export/1158268#1158268
        $
        $ foo="Hello World"
        $ echo $foo
        Hello World
        $ bar="Goodbye"
        $ echo $bar
        Goodbye
        $ export foo
        $ echo $foo
        Hello World
        $ echo $bar
        Goodbye
        $ bash
        $ exit
        exit
        $ bash
        $ echo $foo
        Hello World
        $ echo $bar

        $ exit
        exit
