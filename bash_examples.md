Clean up log files to free up space on the disk. The following command reduces the overall size of log entries for `journalctl` to `10 MB`:

    sudo journalctl --vacuum-size=10M
    
- https://duckduckgo.com/?q=systemd+journal+log+cleanup&ia=web
- https://ma.ttias.be/clear-systemd-journal/

---

Touch screen on Android phone from Terminal:

    adb shell input touchscreen tap 620 100

---

Check checksum match of a file.  
Assuming that the original file and the checksum file are downloaded, and the name of the downloaded file matches the name of the entry in contained in the checksum file.  
Compatible with any checksum `*sum` utility

    md5sum --check ArchLinuxARM-rpi-aarch64-latest.tar.gz.md5

---

Export XML for QEMU VM

    virsh --connect qemu:///system dumpxml Windows_10_Pro_2004.546_x64_LITE > Windows_10_Pro_2004.546_x64_LITE.xml

Import XML for QEMU VM

    virsh --connect qemu:///system define Windows_10_Pro_2004.546_x64_LITE.xml

The contents of the included directories `qemu/nvram` and `images/` need to be copied to the directory `/var/lib/libvirt/`

- https://duckduckgo.com/?q=export+xml+from+qemu+vm&ia=web
- https://unixlikeresearch.blogspot.com/2012/08/how-to-export-virtual-machine.html

---

Check disk for bad blocks / bad sectors

    sudo badblocks /dev/sda -v > "${HOME}/badblocks.txt"
    
Instruct filesystem to avoid these blocks

- for ext2/3/4

        sudo e2fsck -l badsectors.txt /dev/sda10
        
- for other filesystems

        sudo fsck -l badsectors.txt /dev/sda10
    
- https://duckduckgo.com/?q=disk+with+bad+blocks+linux&ia=web
- https://www.tecmint.com/check-linux-hard-disk-bad-sectors-bad-blocks/
- https://duckduckgo.com/?q=check+drive+for+bad+sectors+linux&ia=web
- https://askubuntu.com/questions/241944/how-to-fix-the-hard-drive-bad-sector

---

Check filesystem for errors

works best when run from live distro for all partitions on the disk

    sudo fsck -As
    
- `-A` checks all filesystems
- `-s` moves to the next filesystem noninteractively

- https://duckduckgo.com/?q=fsck+examples&ia=web
- https://www.thegeekstuff.com/2012/08/fsck-command-examples/
- https://duckduckgo.com/?q=fsck+entire+drive&ia=web

---

Check HDD/SSD S.M.A.R.T. status

    sudo smartctl --smart=on /dev/sda

- https://duckduckgo.com/?q=linux+smart+status+hdd&ia=web
- https://www.osradar.com/check-hdd-health-on-linux/
- https://blog.doenselmann.com/festplatten-unter-linux-mit-smart-pruefen/
- https://linuxconfig.org/how-to-check-an-hard-drive-health-from-the-command-line-using-smartctl

---

TRIM SSD

    fstrim --fstab

or

    /usr/bin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo --verbose --quiet-unsupported
    
- `systemctl cat fstrim.service`
- https://github.com/kyberdrb/arch_linux_installation_guide/blob/master/README.md
- https://duckduckgo.com/?q=linux+run+trim+fstrim+manually&ia=web
- https://kb.plugable.com/data-storage/trim-an-ssd-in-linux
- https://askubuntu.com/questions/1242796/how-to-run-fstrim-a-regularly-automatically

---

Case-sensitive replace in `vim`

1. Go to the `cmdline` by pressing `:` when in normal mode or `Esc` and then `:` when in edit mode, or 2x `Esc` and then `:` when in Visual Line mode
1. Enter command

        !sed --in-place 's/gparted/shredos/g' "%"
        
    where
    - `!` enables Shell command execution
    - `sed --in-place` edits the file directly
    - `'s/gparted/shredos/` replaces all occurences of `gparted` with `shredos` in a case-sensitive fashion...
    - `/g'` ... in entire file
    - `"%"` passes the currently opened file for editing with `sed`

---

Complete information about disks and partitions

    lsblk --output KNAME,PATH,TYPE,TRAN,FSTYPE,FSVER,UUID,SIZE,FSUSED,FSAVAIL,MOUNTPOINT,MODEL,SERIAL,STATE,ROTA,DISC-GRAN,DISC-MAX
    
The two columns `DISC-GRAN` and `DISC-MAX` come from `lsblk --discard` command and are used to check whether an SSD drive supports TRIM, for which the TRIM trimer service is recommended to be enabled to prolong the longevity of the SSD drive and to preserve the speeds for as long as possible.

- https://duckduckgo.com/?q=linux+terminal+detailed+ssd+info&ia=web
- https://www.golinuxcloud.com/check-disk-type-linux/

---

Show disk model

    lsblk --output NAME,KNAME,PKNAME,TYPE,MOUNTPOINT,MODEL,SERIAL

---

Pass output of terminal to VSCodium

    lsblk --output-all | vscodium -

---

Protect 7z archive with password

    date && time 7z a -t7z -m0=lzma2 -mx=9 -mfb=273 -md=64m -ms=on "-pMY CUSTOM P@SSW0RD" /path/to/archive.7z /path/to/one/or/more/files/or/directories/ && date

---

Compress a directory into a single archive

    date && time 7z a -t7z -m0=lzma2 -mx=9 -mfb=273 -md=64m -ms=on ARCHIVE_NAME.7z /path/to/directory/ && date

Compress a directory into an multi-part archive with each part at most 4GB large

    date && time 7z a -t7z -m0=lzma2 -mx=9 -mfb=273 -md=64m -ms=on -v4g ARCHIVE_NAME.7z /path/to/directory/ && date
    
Compression command `7z` is wrapped around with `date` and `time` utilities to measure compression duration.

---

Extract a multi-part archive

    find . -mindepth 1 -maxdepth 1 -type f -name "Lehrmaterialien-20220902T063833Z-00*" | sort | xargs -I {} 7z x "{}"

---

Replace character in line number range in vim

    49,59s/#/ /g

Replace character in line number range in sed

    sed --in-place '1,38s/[0-9]/#/g' <FILE>

Both line number boundaries in both cases are inclusive

Source: https://stackoverflow.com/questions/36149036/find-and-replace-text-in-a-file-between-range-of-lines-using-sed/59265882#59265882

---

Make a soft/symbolic link - equivalent to a 'shortcut' in Windows

    ln --symbolic --force /path/to/source_file_or_directory link_name_or_/path/to/destination

---

Check OS version of Linux-based operating system

    cat /etc/os-release

Source:
- https://duckduckgo.com/?q=show+os+version+name+linux&ia=web

---

Quick arithmetics in terminal without `bc`

    python -c "print(0.77 / 0.125)"
    perl -e "print 0.77 / 0.125"
    
Sources:
- https://duckduckgo.com/?q=python+one+liner+terminal+execute+command&ia=web
- https://stackoverflow.com/questions/58730698/how-to-run-one-line-python-command-in-terminal#58730761

---

Delete an entry from history

    history -d 616
   
Source: `history --help`

---

Find biggest files and directories

recursively in the entire filesystem

    date && time find / -mindepth 1 -exec sh -c 'du -s "{}"' \; 2>/dev/null | sort --numeric-sort --reverse > ~/files_sorted_by_size_from_biggest-20221026-3.txt && date
    
non-recursively/shallowly/specifically only files (and directories as a summary size) in a given directory

    find /home/laptop/.cache -maxdepth 1 -exec sh -c 'du -s "{}"' \; | sort --numeric-sort --reverse
    
Find number of files in a directory

    find /home/laptop/backup-sony_xa1/Phone -maxdepth 1 -exec sh -c 'printf "%s;;;;;;;;;;;; " "{}" && find "{}" | wc -l' \; | sort
    
Show all files in a directory, similar to `--group-directories-first` in `ls`...:
    
    find "/var/cache/pacman/pkg/" -mindepth 1 -maxdepth 1 -printf "%y: %p\n" | sort | less
    
or for script usage...
    
    find "/var/cache/pacman/pkg/" -mindepth 1 -maxdepth 1 -printf "%y:%p\n" | sort | cut --delimiter=':' --fields=1 --complement | less
    
... and `ls` equivalent

    ls --color=auto --group-directories-first -1 "/var/cache/pacman/pkg/" | less

---

Split PDF by pages

    pdfseparate -f 1 -l 5 input.pdf output-page%d.pdf

- `-f number` - Specifies the first page to extract. If -f is omitted, extraction starts with page 1.
- `-l number` - Specifies the last page to extract. If -l is omitted, extraction ends with the last page.

If the separated PDF files have the same size as the original PDF file, preprocess the original PDF with command

    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=doc-compressed.pdf doc.pdf 

Sources:
- https://superuser.com/questions/345086/split-pdf-document-from-command-line-in-linux/1034450#1034450
- https://superuser.com/questions/1321515/splitting-pdf-files-using-pdfseparate-poppler#comment2160189_1321515

---

Unite PDF files

    pdfunite output-page1.pdf output-page2.pdf output-page3.pdf final-pages1-3.pdf

Sources:
- https://superuser.com/questions/345086/split-pdf-document-from-command-line-in-linux/1034450#1034450

---

Check file checksum

... and compare the expected checksum with the actual one.

    test "1cd27bb6560855427bc92260a3313c84" = "$(md5sum /run/media/laptop/DELL_BIOS/Latitude_E5x70_Precision_3510_1.29.4.exe | tr -s '[:blank:]' ' ' | cut -d ' ' -f1)" || echo $? && echo $?

    test "5aca1e59e194adfbf446a2b4daf247667204b861" = "$(sha1sum /run/media/laptop/DELL_BIOS/Latitude_E5x70_Precision_3510_1.29.4.exe | tr -s '[:blank:]' ' ' | cut -d ' ' -f1)" || echo $? && echo $?

    test "bcee0cf466f41414aea19c08e96a2ff9659b0cb9223fcbecd30336e0e2a726da" = "$(sha256sum /run/media/laptop/DELL_BIOS/Latitude_E5x70_Precision_3510_1.29.4.exe | tr -s '[:blank:]' ' ' | cut -d ' ' -f1)" || echo $? && echo $?

---

Convert PDF to PNG image

    pdftoppm -png -rx 300 -ry 300 screenshot.pdf screenshot-image

Source: https://hands-on.cloud/how-to-convert-pdf-to-png-images-and-back-in-linux/

---

Unmount all partitions of a device

    cat /proc/partitions | grep /dev/sdX | rev | cut -d' ' -f1 | rev | grep -v "/dev/sdX$" | xargs -I % sh -c 'sudo umount /dev/%'

Source: Use of xargs commands in Linux - https://www.programmerall.com/article/54662124051/

---

- Copy file between the phone and the computer

    - phone `->` PC

        - copy file

                adb pull /storage/extSdCard/buffer.txt /tmp/buffer.txt
    
        - copy multiple files using a wildcard from phone to PC
  
                adb shell "ls /storage/extSdCard/DCIM/Camera/20211224_0*" | tr -d '\r' | xargs -n1 adb pull

            or
  
                adb shell "ls /storage/extSdCard/DCIM/Camera/20211224_0*" | tr '\r' ' ' | xargs -n1 adb pull
                
            - Sources:
                - https://stackoverflow.com/questions/11074671/adb-pull-multiple-files/11250068#11250068
                - https://stackoverflow.com/questions/11074671/adb-pull-multiple-files/37122195#37122195
                
        - copy a directory recursively, i.e. with all files in the subdirectories

                adb pull /storage/sdcard0/Locus/mapsVector/europe/. .

            Source: https://android.stackexchange.com/questions/87326/recursive-adb-pull/87327#87327
    
    -PC `->` phone
    
        adb push /tmp/buffer.txt /storage/extSdCard/buffer.txt
        adb push Locus/. /storage/sdcard0/
    
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
