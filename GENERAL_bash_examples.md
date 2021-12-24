Show `origin` URL of a git repository

    git remote get-url origin 

Change `origin` URL of a git repository

    git remote set-url origin <new_git_upstream_url>

---

Copy file between the phone and the computer

phone `->` PC

    adb pull /storage/extSdCard/buffer.txt /tmp/buffer.txt
    
  copying multiple files using a wildcard from phone to PC
  
    adb shell "ls /storage/extSdCard/DCIM/Camera/20211224_0*" | tr -d '\r' | xargs -n1 adb pull
  
  or
  
    adb shell "ls /storage/extSdCard/DCIM/Camera/20211224_0*" | tr '\r' ' ' | xargs -n1 adb pull
    
  Sources:
  - https://stackoverflow.com/questions/11074671/adb-pull-multiple-files/11250068#11250068
  - https://stackoverflow.com/questions/11074671/adb-pull-multiple-files/37122195#37122195
    
PC `->` phone
    
    adb push /tmp/buffer.txt /storage/extSdCard/buffer.txt
    
---

'Burn' ISO to USB

Replace `sdx` with your USB drive by using e.g. `lsblk` command

        sudo dd bs=4M if=path/to/archlinux-version-x86_64.iso of=/dev/sdx conv=fsync oflag=direct status=progress
        
Source: https://wiki.archlinux.org/title/USB_flash_installation_medium

---

Extract 7z archive

Extract into directory with archive's name

        7z x -y clonezilla-live-2.7.3-19-amd64.zip -o/run/media/laptop/8071-0AE6
        
Extract directly into current directory

        7z e -y clonezilla-live-2.7.3-19-amd64.zip -o/run/media/laptop/8071-0AE6
        
Source: https://superuser.com/questions/1366616/extract-folder-content-from-7z-archive-to-specific-folder/1366619#1366619

---

Extract link to PDF file for researchgate.net articles

        $ # Link copied from the 'Dowload' button of an article when available
        $ url="https://www.researchgate.net/profile/K-Jayasankara-Reddy/publication/324126634_Academic_Stress_and_its_Sources_Among_University_Students/links/5facd3e545851507810d3bf6/Academic-Stress-and-its-Sources-Among-University-Students.pdf?_sg%5B0%5D=-Teztkijrz63m0E3rNX-WAY_URChls-jlcA7DePD0HOjlABb7oy4CGhmP4cLRcifOA5sXtvC9MHlf53xvDqqig.jIRqPnUdTcUD_Bt5Mxy0R1H6-XXbyZMcR-rParExA2LwN-x0OcXoDeecXUtPnfHyNsImULHXWv2ry8rekin5aQ.MMKJw6HskFi9gdLOGGMALB_DfUqbGExSUH7LE9KN0YHewdeNac3WCcLUUibMMb7NoSJf-gnE8jUZ3Bma5_7iqw&_sg%5B1%5D=i-XBO2eZ1Z9GsusjvW36V8Z-VW4P9oEwkgYao2S8Sg7GTbHph3MhU9GHVdjUyzrB65qic36vYiX5rdB0rS7ps0HeQFXzVidEWQG4gQlGg0NW.jIRqPnUdTcUD_Bt5Mxy0R1H6-XXbyZMcR-rParExA2LwN-x0OcXoDeecXUtPnfHyNsImULHXWv2ry8rekin5aQ.MMKJw6HskFi9gdLOGGMALB_DfUqbGExSUH7LE9KN0YHewdeNac3WCcLUUibMMb7NoSJf-gnE8jUZ3Bma5_7iqw&_iepl%5BgeneralViewId%5D=N6cg1WuANscvFS9JqCPW4wR16uNn4H4oX2NK&_iepl%5Bcontexts%5D%5B0%5D=searchReact&_iepl%5BviewId%5D=ULHui0NiYoBzfcW83F5iR1yeBiRIWNusROyo&_iepl%5BsearchType%5D=publication&_iepl%5Bdata%5D%5BcountLessEqual20%5D=1&_iepl%5Bdata%5D%5BinteractedWithPosition1%5D=1&_iepl%5Bdata%5D%5BwithoutEnrichment%5D=1&_iepl%5Bposition%5D=1&_iepl%5BrgKey%5D=PB%3A324126634&_iepl%5BtargetEntityId%5D=PB%3A324126634&_iepl%5BinteractionType%5D=publicationDownload"
        
        $ # Trimmed link is easier to read and is enough to access the PDF file of an article
        $ echo ${url%%\?*}
        https://www.researchgate.net/profile/K-Jayasankara-Reddy/publication/324126634_Academic_Stress_and_its_Sources_Among_University_Students/links/5facd3e545851507810d3bf6/Academic-Stress-and-its-Sources-Among-University-Students.pdf

---

Removing special characters from text or filenames

        echo 'Long-term follow-up of Helicobacter pylori reinfection and its risk factors after initial eradication: a large-scale multicentre, prospective open cohort, observational study--TEMI_9_1737579.pdf' | sed 's/:/_-_/g' | tr -d '<>"/\|?*(),""“”!' | tr -d "'" | sed 's/ /_/g' | sed 's/__/_/g' | tr -d '\r\n' | xclip -selection clipboard

- https://stackoverflow.com/questions/1976007/what-characters-are-forbidden-in-windows-and-linux-directory-names/31976060#31976060

---

Doing date arithmetics

- adding to current date

        date +%d.%m.%Y -d "4 weeks"
    
- subtracting from current date

        date +%d.%m.%Y -d "4 weeks ago"
   
- https://stackoverflow.com/questions/6417233/how-to-do-date-calculations-in-shell-scripting/6417313#6417313
- https://man7.org/linux/man-pages/man1/date.1.html

---

Convert image with text to a text file

    tesseract -l slk image_with_text.jpeg file_with_extracted_text
    
The `file_with_extracted_text` will be in the same directory and prepended with `.txt` extension by default, i.e. `file_with_extracted_text.txt`

---

Convert PDF to text

    pdftotext DOCUMENT.pdf
    
https://www.howtogeek.com/228531/how-to-convert-a-pdf-file-to-editable-text-using-the-command-line-in-linux/

---

Remove known password from a PDF file

    qpdf --password=ENTER_YOUR_PASSWORD_HERE --decrypt ENCRYPTED_FILE.pdf DECRYPTED_FILE.pdf

https://www.cyberciti.biz/faq/removing-password-from-pdf-on-linux/

---

Show the upstream URL for a git repository

    cat .git/config | grep url | tr -d '\t' | tr -d ' ' | cut -d'=' -f2 | xclip -se c

---

Rename all files in a directory - add a prefix to their filename

    find . -name '*.log' -exec bash -c 'mv "$1" "$(dirname $1)/interbench-$(basename $1)"' bash "{}" \;

---

Recursively rename all files, directories etc. that contain spaces in their filenames with underscores:

    find . -name '* *' -exec bash -c 'mv "$1" "${1// /_}"' bash "{}" \;

* https://unix.stackexchange.com/questions/172186/find-xargs-and-mv-renaming-files-with-double-quotes-expansion-and-bash-preced/172196#172196
* https://unix.stackexchange.com/questions/389705/understanding-the-exec-option-of-find/389706#389706
* if you want to use regex: https://stackoverflow.com/questions/6844785/how-to-use-regex-with-find-command/6845194#6845194

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
