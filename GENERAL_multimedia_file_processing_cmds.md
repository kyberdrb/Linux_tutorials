## Download

        MEDIA_URL=youtube/soundcloud/vimeo/etc.
        youtube-dl --verbose --list-formats $MEDIA_URL
        
        youtube-dl --verbose --format <format> --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --format <format> $MEDIA_URL
        
        youtube-dl --verbose --list-sub $MEDIA_URL
        
        youtube-dl --verbose --write-auto-sub --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --write-auto-sub --sub-lang <language> --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --write-sub --sub-lang <language> --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --write-sub --sub-lang <language> --skip-download $MEDIA_URL
        
        youtube-dl --verbose --write-auto-sub --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --write-auto-sub --sub-lang en --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        
* https://superuser.com/questions/927523/how-to-download-only-subtitles-of-videos-using-youtube-dl
* https://askubuntu.com/questions/948516/how-do-i-download-with-youtube-dl-to-get-video-title-as-filename/948531#948531
        
`--write-auto-sub` option can be used only for Youtube videos, according to the man page.

## Merge

Merge audio and video file to a single file

        ffmpeg -i video_without_audio.mp4 -i audio_without_video.m4a -c copy video_with_audio-merged.mp4

* https://gist.github.com/aik099/69f221d100b87cb29f4fb6c29d72838e#file-vimeo-downloader-js-L40
* https://stackoverflow.com/questions/38379412/what-does-copy-do-in-a-ffmpeg-command-line/38381173#38381173

## Convert

        ffmpeg -i file_name.webm -vn -y -b:a 128k -ar 44100 converted_file_name.ogg
        ffmpeg -i file_name.webm -vn -y -b:a 128k -ac <channels: 1 - mono, 2 - stereo> -ar 44100 converted_file_name.ogg
        ffmpeg -i file_name.webm -vn -y converted_file_name.ogg
        
* https://stackoverflow.com/questions/42947957/how-convert-high-bitrate-mp3-to-lower-rate-using-ffmpeg-in-android/49433551#49433551
* https://trac.ffmpeg.org/wiki/AudioChannelManipulation

## Cut

        ffmpeg -ss "11:23:16.000" -to "11:53:28.000" -i /full/path/to/file.ogg /full/path/to/cut_file.ogg

## Batch convert

        parallel 'ffmpeg -i "{}" -c:a libvorbis -vn -y "{.}.ogg"' ::: $(ls *.webm *.mp3 *.m4a)
        parallel 'ffmpeg -i "{}" -c:a libvorbis -vn -b:a 64k -y "{.}.ogg"' ::: $(ls *.webm *.mp3 *.m4a)

* https://gist.github.com/Brainiarc7/18fca697891aea0e879f13ed092cb213

**Note:** Before running `parallel`, make sure the file name contains only alphanumeric characters and symbols.
The file name mustn't contain white characters, like spaces, unique language characters, like 'ö', 'ä', 'ß' etc.
Otherwise `parallel` splits the filename and treats them as multiple files which produces and error message 
or it ignores them altogether

## Integrate chapters for a video

Extract Metadata From Video

        ffmpeg -i INPUT.mp4 -f ffmetadata FFMETADATAFILE.txt

Create chapter file. Example of a chapter file:

        [CHAPTER]
        TIMEBASE=1/1000
        START=1
        END=448000
        title=The Pledge

        [CHAPTER]
        TIMEBASE=1/1000
        START=448001
        END= 3883999
        title=The Turn

        [CHAPTER]
        TIMEBASE=1/1000
        START=3884000
        END=4418000
        title= The Prestige

Write Metadata To Video

        ffmpeg -i INPUT.mp4 -i FFMETADATAFILE.txt -map_metadata 1 -codec copy OUTPUT.mp4

* https://ikyle.me/blog/2020/add-mp4-chapters-ffmpeg
