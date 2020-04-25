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
        

Show length of a media file
- the `2>&1` redirection filters out the details of the output leaving only the duration visible

        ffprobe "MEDIA_FILE_NAME" 2>&1 | awk '/Duration/ { print $2 }' | cut -d',' -f1

Move files to trash

    gio trash FILENAME
    gio list trash://
    gio trash --empty
    # https://wiki.archlinux.org/index.php/Trash_management
