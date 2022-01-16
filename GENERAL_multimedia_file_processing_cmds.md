## Download

        MEDIA_URL=youtube/soundcloud/vimeo/etc.
        
### Download audio/video
        
List formats for audio/video

        youtube-dl --verbose --list-formats $MEDIA_URL
        
Download specified audio/video format

        youtube-dl --verbose --format <format> --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL

### Download subtitles

... when available.

List subtitiles

        youtube-dl --verbose --list-sub $MEDIA_URL
        
Download auto-generated subtitles (YouTube)

        youtube-dl --verbose --write-auto-sub --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --write-auto-sub --sub-lang <language> --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --write-auto-sub --sub-lang en-US --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        
`--write-auto-sub` option can be used only for Youtube videos, according to the man page of `youtube-dl`.
        
Download explicitely written subtitles

        youtube-dl --verbose --write-sub --sub-lang <language> --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --write-sub --sub-lang en --skip-download --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --write-sub --sub-lang <language> --skip-download $MEDIA_URL        

* https://superuser.com/questions/927523/how-to-download-only-subtitles-of-videos-using-youtube-dl
* https://askubuntu.com/questions/948516/how-do-i-download-with-youtube-dl-to-get-video-title-as-filename/948531#948531
        
To convert explicitely written subtitles to a plain text file from YouTube and copy it to clipboard, you can use command:

    cat <youtube_subtitle_file> | sed '1,4d' |  sed '/-->/d' | sed '/^$/d' | tr -s "\n" " " | xclip -selection clipboard
    
or for auto-generated YouTube subtitles use:

    cat <youtube_subtitle_file> | sed '1,4d' |  sed '/-->/d' | sed -e '/<c>/d' | sed '/^\s*$/d' | uniq | tr -s '\n' ' ' | xclip -selection clipboard
    
### Download private YouTube video

Install 'cookies.txt' extension (Chrome/Chromium); log in to the Google Account when the access to the video is allowed only for specified users; open the link to the private YouTube video; click the 'cookies.txt' extension icon and in the top part of the output click on 'To download cookies for this tab click here'.
        
    youtube-dl --cookies ~/Downloads/cookies-youtube-private_videos.txt --verbose --format 248+251 --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" https://www.youtube.com/watch?v=ghHe1bN3mi0
        
- https://daveparrish.net/posts/2018-06-22-How-to-download-private-YouTube-videos-with-youtube-dl.html

## Merge

### Merge audio and video file

Merge audio and video file to a single file

    ffmpeg -i video_without_audio.mp4 -i audio_without_video.m4a -c copy video_with_audio-merged.mp4

* https://gist.github.com/aik099/69f221d100b87cb29f4fb6c29d72838e#file-vimeo-downloader-js-L40
* https://stackoverflow.com/questions/38379412/what-does-copy-do-in-a-ffmpeg-command-line/38381173#38381173

### Merge multiple video files already containing audio

1. Sort downloaded videos by download time from oldest to newest
  
        ls -1 -t sarah_cokova900_* | tac | sed 's/^/file /g' > sarah_cokova_playlist.txt

1. Concatenate videos together. If one command doesn't produce a video that you're satisfied with, try different ones.

        ffmpeg -f concat -i sarah_cokova_playlist.txt -c copy sarah_cokova_profile_story-2021_01_16.mp4

        ffmpeg -f concat -safe 0 -i sarah_cokova_playlist.txt -c copy sarah_cokova_profile_story-2021_01_16.mp4

        ffmpeg -safe 0 -f concat -segment_time_metadata 1 -i sarah_cokova_playlist.txt -vf select=concatdec_select -af aselect=concatdec_select,aresample=async=1 sarah_cokova_profile_story-2021_01_16.mp4
        
- https://filme.imyfone.com/video-editing-tips/how-to-merge-or-combine-videos-using-ffmpeg/
- https://blog.feurious.com/concatenate-videos-together-using-ffmpeg
- https://duckduckgo.com/?q=ffmpeg+this+may+result+in+incorrect+timestamps+in+the+output+file&ia=web
- https://stackoverflow.com/questions/53021266/non-monotonous-dts-in-output-stream-previous-current-changing-to-this-may-result#53021506
- https://duckduckgo.com/?q=ffmpeg+safe+0&ia=web

## Convert

    ffmpeg -i file_name.webm -vn -y -b:a 128k -ar 44100 converted_file_name.ogg
    ffmpeg -i file_name.webm -vn -y -b:a 128k -ac <channels: 1 - mono, 2 - stereo> -ar 44100 converted_file_name.ogg
    ffmpeg -i file_name.webm -vn -y converted_file_name.ogg

* https://stackoverflow.com/questions/42947957/how-convert-high-bitrate-mp3-to-lower-rate-using-ffmpeg-in-android/49433551#49433551
* https://trac.ffmpeg.org/wiki/AudioChannelManipulation

**Convert from higher resolution to lower resolution to save space on the storage**

From Full HD (1080p) to HD (720p)

    ffmpeg -i large_full_hd_video.mkv -s hd720 -c:v libx264 -preset slow -crf 23 -c:a aac -strict -2 smaller_hd_video.mkv
    
The resulting file will be approximately 3-4x smaller than the original file with negligible quality difference.

* https://askubuntu.com/questions/99643/how-can-i-convert-a-1080p-wmv-video-to-a-720p-video/99648#99648
* https://superuser.com/questions/1556953/why-does-preset-veryfast-in-ffmpeg-generate-the-most-compressed-file-compared#1557090
* `-crf` meaning - https://trac.ffmpeg.org/wiki/Encode/H.264
        
**Decode and convert AAX or other Amazon Audible audio file**

... for personal use, of course

        pikaur -Syy audible-activator-git
        audible-activator
        [enter username/email and password]
        # Copy the text after the 'activation_bytes:'
        # Convert audio file with given activation bytes. I preffer to use 'libvorbis' encoder, as it's open-source.
        #  You can choose different encoders. List of supported encoders can be obtained with the command 'ffmpeg -encoders'
        ffmpeg -activation_bytes ACTIVATION_BYTES -i AudioFile.aax -vn -c:a libvorbis AudioFile.ogg
        
* https://unix.stackexchange.com/questions/105821/audible-drm-removal-for-personal-use/408053#408053
* https://ffmpeg.org/ffmpeg-codecs.html#toc-Encoders

## Cut

        ffmpeg -i media_file.mkv -ss "00:05:18.000" -c copy -avoid_negative_ts 1 -to "01:03:40.000" -async 1 media_file-cut.mkv
        
- `-avoid_negative_ts 1` argument is there to prevent error when working with Matroska `mkv` files.
- The order of the commands matters. When the commands are not in this exact order/placement (in between the input and output file?), the trimming might end up inaccurate.

- Sources
    - https://duckduckgo.com/?q=ffmpeg+cut+trim+video+by+time&ia=web
    - https://www.joyoshare.com/video-cutting/ffmpeg-trim-cut-video.html
    - "Fix some first seconds freeze, **the order of command parameter is matter**." [emphasis mine] - https://cheatortrick.blogspot.com/2019/05/ffmpeg-4-crop-flac.html
    - https://stackoverflow.com/questions/18444194/cutting-the-videos-based-on-start-and-end-time-using-ffmpeg/58059148#58059148
    - https://stackoverflow.com/questions/18444194/cutting-the-videos-based-on-start-and-end-time-using-ffmpeg/18449609#18449609

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
