## Download

        MEDIA_URL=youtube/soundcloud/vimeo/etc.
        youtube-dl --verbose --list-formats $MEDIA_URL
        youtube-dl --verbose --format <format> $MEDIA_URL
        youtube-dl --write-sub --sub-lang <language> --skip-download $MEDIA_URL
        # https://superuser.com/questions/927523/how-to-download-only-subtitles-of-videos-using-youtube-dl/1353474#1353474


## Convert

        ffmpeg -i file_name.webm -vn -y converted_file_name.ogg

## Cut

        ffmpeg -ss "11:23:16.000" -to "11:53:28.000" -i /full/path/to/file.ogg /full/path/to/cut_file.ogg

## Batch convert

        parallel 'ffmpeg -i "{}" -c:a libvorbis -vn -b:a 64k -y "{.}.ogg"' ::: $(ls *.webm *.mp3 *.m4a)
        parallel 'ffmpeg -i "{}" -c:a libvorbis -vn -y "{.}.ogg"' ::: $(ls *.webm *.mp3 *.m4a)
        (https://gist.github.com/Brainiarc7/18fca697891aea0e879f13ed092cb213)

**Note:** Before running `parallel`, make sure the file name contains only alphanumeric characters and symbols.
The file name mustn't contain white characters, like spaces, unique language characters, like 'ö', 'ä', 'ß' etc.
Otherwise `parallel` splits the filename and treats them as multiple files which produces and error message 
or it ignores them altogether
