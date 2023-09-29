## Download

        MEDIA_URL=youtube/soundcloud/vimeo/MPD stream/etc.
        
### Download audio/video
        
List formats for audio/video

        youtube-dl --verbose --list-formats $MEDIA_URL
        
Download specified audio/video format

        youtube-dl --verbose --format <audio_video_format> --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        
        youtube-dl --verbose --format <audio_only_format> --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
        youtube-dl --verbose --format <video_only_format> --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" $MEDIA_URL
   
or download multiple formats - useful for separated audio and video streams

        youtube-dl --verbose --format FORMAT_CODE_FOR_AUDIO,FORMAT_CODE_FOR_VIDEO --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" ${MEDIA_URL}
        youtube-dl --verbose --format FORMAT_CODE_1,FORMAT_CODE_2,...,FORMAT_CODE_N --output "%(title)s-%(extractor)s-%(id)s.%(ext)s" ${MEDIA_URL}

* https://stackoverflow.com/questions/31846530/given-a-mpeg-dash-mpd-url-is-that-possible-to-down-all-media-segments-through
* https://stackoverflow.com/questions/62447887/how-to-download-mpeg-dash-mpd-file-using-youtube-dl-when-headers-are-requested#62554037

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
* https://duckduckgo.com/?q=youtube-dl+download+mpd+stream&ia=web
        
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

    ffmpeg -i video_without_audio.mp4 -i audio_without_video.m4a -codec copy -avoid_negative_ts 1 -async 1 video_with_audio-merged.mp4

* https://gist.github.com/aik099/69f221d100b87cb29f4fb6c29d72838e#file-vimeo-downloader-js-L40
* https://stackoverflow.com/questions/38379412/what-does-copy-do-in-a-ffmpeg-command-line/38381173#38381173

### Merge multiple video files already containing audio

1. Sort downloaded videos by download time from oldest to newest
  
        find . -name "*.m4v" | sed 's/^/file /g' > video_list.txt
  
    or
  
        ls -1 -t file_common_prefix_* | tac | sed 's/^/file /g' > video_list.txt

1. Concatenate videos together. If one command doesn't produce a video that you're satisfied with, try different ones.

        ffmpeg -f concat -i video_list.txt -c copy resulting_output_video.mp4

        ffmpeg -f concat -safe 0 -i video_list.txt -c copy resulting_output_video.mp4

        ffmpeg -safe 0 -f concat -segment_time_metadata 1 -i video_list.txt -vf select=concatdec_select -af aselect=concatdec_select,aresample=async=1 resulting_output_video.mp4
        
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

## Cut/Trim

### Fast Cut (faster, but sometimes inaccurate)

        $ ffmpeg -ss 00:23:23.000 -to 00:25:41.000 -i input_video.mp4 -codec copy -avoid_negative_ts 1 -async 1 -map_metadata -1 output_video-from_HH_MM_SS_to_HH_MM_SS-COARSE.mp4
        $ mv output_video-from_HH_MM_SS_to_HH_MM_SS-COARSE.mp4 output_video-from_HH_MM_SS_to_HH_MM_SS.mp4

Previously I used:

        $ ffmpeg -i media_file.mkv -ss "00:05:18.000" -c copy -avoid_negative_ts 1 -to "01:03:40.000" -async 1 media_file-cut.mkv
        
but now I found out that specifying the `-ss` option enables output seeking, which might be less accurate and cause freezing at start for approximately 1 second. Therefore I use the 'Input Seeking' with `-ss` to fix the freezing at the start.

### Accurate Cut (slower, but more accurate)

... bit still bearable when first doing coarse cut, and then accurate cut on the coarsely cut media file.

        $ ffmpeg -ss 00:23:23.000 -to 00:25:41.000 -i input_video.mp4 -c copy -avoid_negative_ts 1 -async 1 output_video-COARSE.mp4

maybe add one second to the `-ss` option in the command for 'ACCURATE' video output to trim the coarsely trimmed video exactly?

calculate the time difference between 'COARSE' and desired start time for `-ss` option  with formula `1/25 * number_of_frames_to_desired_start_time` where `1` is one second, `25` is number of frames per second that the video had been encoded, `1/25` is duration of one frame, and the entire result is the total duration of all frames between current and desired beginning frame. You can count the frames manually by opening the 'COARSE' video in `mpv` player and pressing the dot key `.` to go forward by one frme - or comma key `,` for going backwards by one frame - and counting number of frames in your head until you reach the frame that you want the final video to start with.

        $ ffmpeg -ss 00:00:02.080 -i output_video-COARSE.mp4 -codec:video h264 -codec:audio aac -avoid_negative_ts 1 -async 1 -map_metadata -1 output_video-from_HH_MM_SS_to_HH_MM_SS-ACCURATE.mp4
        $ output_video-from_HH_MM_SS_to_HH_MM_SS-ACCURATE.mp4 output_video-from_HH_MM_SS_to_HH_MM_SS.mp4

### Notes

- `-ss` argument right after `ffmpeg` command fixes the one-second-freeze when starting playing the media file
- `-avoid_negative_ts 1` argument is there to prevent error when working with Matroska `mkv` files
- `-async 1` argument synchronizes audio with video
- `-map_metadata -1` argument strips the metadata to fix buggy seeking and media file length

Manually specifying codecs with `-codec` flag will reencode the entire input media file with specified codecs, which is slower but assures that the output file will be cut more accurately.

The order of the commands matters. When the commands are not in this exact order/placement (in between the input and output file?), the trimming might end up inaccurate.

- Sources
    - https://duckduckgo.com/?q=ffmpeg+cut+trim+video+by+time&ia=web
    - https://www.joyoshare.com/video-cutting/ffmpeg-trim-cut-video.html
    - "Fix some first seconds freeze, **the order of command parameter does matter**." [emphasis mine] - https://cheatortrick.blogspot.com/2019/05/ffmpeg-4-crop-flac.html
    - https://stackoverflow.com/questions/18444194/cutting-the-videos-based-on-start-and-end-time-using-ffmpeg/58059148#58059148
    - https://stackoverflow.com/questions/18444194/cutting-the-videos-based-on-start-and-end-time-using-ffmpeg/18449609#18449609
    - https://video.stackexchange.com/questions/16516/ffmpeg-first-second-of-cut-video-part-freezed
    - https://video.stackexchange.com/questions/16516/ffmpeg-first-second-of-cut-video-part-freezed/16640#16640
    - https://trac.ffmpeg.org/wiki/Seeking
        - **using 'Input seeking' - `-ss` flag right after `ffmpeg` command**
    - https://duckduckgo.com/?q=ffmpeg+async+1&ia=web
    - https://ffmpeg.org/ffmpeg.html#toc-Advanced-options
    - https://duckduckgo.com/?q=ffmpeg+order+of+parameters&ia=web&iax=qa
    - https://superuser.com/questions/1370461/what-are-ffmpeg-video-audio-stream-parameters-in-order#1370484
    - https://duckduckgo.com/?q=ffmpeg+ss+not+accurate+copy&ia=web
    - https://superuser.com/questions/1129396/ffmpeg-ss-t-seeking-output-is-not-accurate-any-workarounds#1131129
    - https://duckduckgo.com/?q=ffmpeg+list+codect&ia=web
    - https://stackoverflow.com/questions/3377300/what-are-all-codecs-and-formats-supported-by-ffmpeg#3377312
    - https://duckduckgo.com/?q=specify+codec+ffmpeg&ia=web
    - https://stackoverflow.com/questions/18444194/cutting-the-videos-based-on-start-and-end-time-using-ffmpeg
    - https://stackoverflow.com/questions/18444194/cutting-the-videos-based-on-start-and-end-time-using-ffmpeg/42827058#42827058
    - https://duckduckgo.com/?q=ffmpeg+remove+metadata&ia=web
        - stripping metadata fixes buggy seeking and total media file length in the output file
    - https://superuser.com/questions/441361/strip-metadata-from-all-formats-with-ffmpeg
    - https://superuser.com/questions/441361/strip-metadata-from-all-formats-with-ffmpeg/979186#979186
    - https://superuser.com/questions/441361/strip-metadata-from-all-formats-with-ffmpeg/428039#428039

## Batch convert

        parallel 'ffmpeg -i "{}" -c:a libvorbis -vn -y "{.}.ogg"' ::: $(ls *.webm *.mp3 *.m4a)
        parallel 'ffmpeg -i "{}" -c:a libvorbis -vn -b:a 64k -y "{.}.ogg"' ::: $(ls *.webm *.mp3 *.m4a)

* https://gist.github.com/Brainiarc7/18fca697891aea0e879f13ed092cb213

**Note:** Before running `parallel`, make sure the file name contains only alphanumeric characters and symbols.
The file name mustn't contain white characters, like spaces, unique language characters, like 'ö', 'ä', 'ß' etc.
Otherwise `parallel` splits the filename and treats them as multiple files which produces and error message 
or it ignores them altogether

## Integrate chapters for a video

Extract base metadata from the video

        ffmpeg -i INPUT.mp4 -f ffmetadata FFMETADATAFILE.txt
        
        # Exmple of a metadata file without chapters
        $ cat FFMETADATAFILE.txt
        
        ;FFMETADATA1
        major_brand=isom
        minor_version=512
        compatible_brands=isomiso2avc1mp41
        encoder=Lavf59.16.100

Create chapter file. Example of a chapter file:

        $ cat chapters.metadata

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
        
Create complete metadata file by concatenating the base metadata with the chapter metadata

        cat FFMETADATAFILE.txt chapters.metadata | head --lines=-1 > FFMETADATAFILE.metadata_with_chapters
        
        ;FFMETADATA1
        major_brand=isom
        minor_version=512
        compatible_brands=isomiso2avc1mp41
        encoder=Lavf59.16.100

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
        
See https://github.com/kyberdrb/Linux_tutorials/blob/master/GENERAL_add_chapters_into_mp4_video_file/chapters_metadata.txt for another example file with complete metadata with chapters.

Write Metadata To Video

        ffmpeg -i INPUT.mp4 -i FFMETADATAFILE.metadata_with_chapters -map_metadata 1 -map_chapters 1 -codec copy OUTPUT.mp4
        
Verify chapter integration
        
        vlc OUTPUT.mp4 &
        mpv OUTPUT.mp4 &

* https://ikyle.me/blog/2020/add-mp4-chapters-ffmpeg

---

## How convert 2 DVDs to one multimedia file with chapter marks and metadata

### **Video extraction part** a.k.a. **The Windows part** - ISO maker: `dd`, DVD ripper: `Handbrake`

#### [OPTIONAL - RECOMMENDED] The cloning part

1. Make an ISO from the DVDs. When something goes wrong, ripping from local ISO files is much faster than from the DVD itself. Install `Git` in order to get `Git Bash`.

1. Open `Git Bash` and enter command

        dd if=/dev/sr0 of=/c/Users/${USER}/Downloads/stuzkova_dvd_1.iso

    to make an ISO image from the DVD. For the second DVD, use different name to avoid overwriting e.g. `stuzkova_dvd_2.iso`

    - https://duckduckgo.com/?q=linux+cd+to+iso&ia=web
    - https://www.addictivetips.com/ubuntu-linux-tips/cd-rom-to-iso-linux/

1. [Optional] Upload both images to cloud as a backup
1. Mount both ISO images. Now we will proceed to the ripping part.

#### The ripping part

1. Install `Handbrake`.

    - https://duckduckgo.com/?q=convert+dvd+iso+to+mp4+linux&ia=web

1. Before running Hanbrake, install its dependency .NET CORE **DESKTOP** Runtime from

    > https://dotnet.microsoft.com/en-us/download/dotnet/6.0

    Look for section `.NET Desktop Runtime 6.0.9` `>` row `Windows` `>` column `Installers` `>` `x64` link

    Verify installation in PowerShell/Command Prompt with command

        dotnet --info

    Example output

    ```
    machine@DESKTOP-VD391FO MINGW64 ~
    $ dotnet --info

    global.json file:
    Not found

    Host:
    Version:      6.0.9
    Architecture: x64
    Commit:       163a63591c

    .NET SDKs installed:
    No SDKs were found.

    .NET runtimes installed:
    Microsoft.NETCore.App 6.0.9 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
    Microsoft.WindowsDesktop.App 6.0.9 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]

    Download .NET:
    https://aka.ms/dotnet-download

    Learn about .NET Runtimes and SDKs:
    https://aka.ms/dotnet/runtimes-sdk-info
    ```

    - https://duckduckgo.com/?q=handbrake+to+run+this+application+you+must+install&ia=web
    - https://github.com/HandBrake/HandBrake/issues/4145#issuecomment-1055770896

1. Open `Handbrake` and select the mounted DVD 1 as a source.
1. Rip the DVD 1 with following settings. If you're not sure, which settings to use, open `VLC` media player, click on `Media > Open Disc`, select the mounted disk, and press `Play`, then `Pause` the video, right click on the displazed video, and from the context menu choose `Tools > Codec information`
    - Preset: Fast 576p25
    - Audio:
        - AAC (avcodec)
        - Bitrate: 320kbps
        - Mixdown: Stereo
        - Samplerate: Auto
    - Video:
        - Video Encoder:
            - **MPEG-2** - **PREFERRED** - the original video format on the DVD, in order to preserve as much information as possible and minimize conversions and transcoding; bigger output file size, shorter conversion
                - Constant Quality: `30` set by the slider
            - H.264 - smaller output file size, longer conversion
        - Cropping: Custom: `0` from all sides
    - Chapters: all checked
    - Summary
        - Align A/V start
        - Passthru common metadata

    In the `Save As` line edit the path to, e.g. `C:\Users\<USERNAME>\Downloads\stuzkova_dvd_1.m4v`

    Press `Start Encoding` button in the top menu bar.

    Then Rip of DVD 2 with the same preset and settings. Mount the ISO for the second DVD, open it by clicking on `Open Source` in the top menu bar, edit the output file name to `stuzkova_dvd_2.m4v`, and then **either** click on `Add to Queue`, when the first DVD is still being converted, **or** on `Start Encoding` when there are no active encoding tasks.

1. Test the rips by playing them in some media player, e.g. `VLC`. Check
1. Copy the rips to a shared storage, e.g. USB drive, copy it to a Linux machine and continue with metadata extraction, video concatenation, chapter times processing and metadata integration.

### **Video postprocessing part** a.k.a. **The Linux part** - multimedia utility: `ffmpeg`, spreadsheet editor: `Calc`, text editor: `VSCodium`

1. Concatenate the two video multimedia files together. I assume that they are in the same directory.

    First create the list of the multimedia files

        find . -maxdepth 1 -name "*.m4v" | sed 's/^/file /g' | sort > stuzkova_video_list.txt

    [Example contents:](res/stuzkova_video_list.txt)

        cat stuzkova_video_list.txt

    ```
    file ./stuzkova_dvd_1.m4v
    file ./stuzkova_dvd_2.m4v
    ```

    Then pass the video list to the ffmpeg

        ffmpeg -f concat -safe 0 -i stuzkova_video_list.txt -codec copy stuzkova.mkv

    - https://duckduckgo.com/?q=ffmpeg+concat+Unsupported+audio+codec+aac&ia=web
    - https://stackoverflow.com/questions/61740522/ffmpeg-he-aac-unsupported-codec-despite-being-compiled-with-support

    When you choose the `mkv` format for compatibility reasons, because when I named the output file with the extension `m4v` as originally, I got an error
    
    ```
    [ipod @ 0x555ea5db7ec0] Tag mp4v incompatible with output codec id '2' ([0][0][0][0])
    Could not write header for output file #0 (incorrect codec parameters ?): Invalid data found when processing input
    Error initializing output stream 0:1 --
    ```
    
    and when I changed the extension to `mpg` I got another error

    ```
    [mpeg @ 0x55b5edcd9ec0] Unsupported audio codec. Must be one of mp1, mp2, mp3, 16-bit pcm_dvd, pcm_s16be, ac3 or dts.
    Could not write header for output file #0 (incorrect codec parameters ?): Invalid argument
    Error initializing output stream 0:1 --
    ```

    _or you can try other options that produce less quality output files... but why bother - left here only for reference_

        ffmpeg -f concat -safe 0 -i stuzkova_video_list.txt -codec copy -f mpegts stuzkova.mpg

        ffmpeg -f concat -safe 0 -segment_time_metadata 1 -i stuzkova_video_list.txt -vf select=concatdec_select -af aselect=concatdec_select,aresample=async=1 -codec:a aac -f mpegts stuzkova.mpg

        # fixing A/V desync and split second freeze at start, therefore ommiting '-codec copy' and adding time sync because
        Filtergraph 'select=concatdec_select' was defined for video output stream 0:0 but codec copy was selected.
        Filtering and streamcopy cannot be used together.

    `-codec copy` copies all the streams without reencoding which makes the concatenation faster.

    - https://stackoverflow.com/questions/61740522/ffmpeg-he-aac-unsupported-codec-despite-being-compiled-with-support#comment109270643_61742550
        - explicitly defining the output format with option `-f mpegts`
    - `man ffmpeg` - then search for `-codec copy`

1. Extract metadata from videos for both DVDs

        ffmpeg -i stuzkova_dvd_1.m4v -f ffmetadata stuzkova_dvd_1.m4v.metadata.txt
        ffmpeg -i stuzkova_dvd_2.m4v -f ffmetadata stuzkova_dvd_2.m4v.metadata.txt

    Example files for [metadata for DVD 1](res/stuzkova_dvd_1.m4v.metadata.txt) and [DVD2](res/stuzkova_dvd_2.m4v.metadata.txt)

1. Create a spreadsheet file. We will use it to recalculate chapter time for the second DVD video.

1. Find out the length of the first video in milliseconds

        ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 stuzkova_dvd_1.m4v | tr --delete '.' | cut --characters=1-7

    - https://duckduckgo.com/?q=ffmpeg+get+video+length&ia=web&iax=qa
    - https://superuser.com/questions/650291/how-to-get-video-duration-in-seconds#945604

    Then paste the length of the first video to the spreadsheet.

1. Open the metadata text file for the first DVD video `stuzkova_dvd_1.m4v.metadata.txt` and check the number of the last chapter - assuming the chapters are numbered and numbers go consecutively.

    Then paste the number of the last chapter from the first video to the spreadsheet.

1. Open the metadata text file for the second DVD video `stuzkova_dvd_2.m4v.metadata.txt`, select everything `Ctrl + A`, copy it and paste it to the spreadsheet.

1. In the spreadsheet file, shift chapter metadata from the second video forward for the length of the first video, i.e. add to all start and end chapter times the length of the second video, to make timestamps valid and accurate after the merge of the video. See the [example spreadsheet](res/chapter_times_recalculation_for_second_video.ods) file for illustration.

    - https://duckduckgo.com/?q=concatenate+cells+string+calc&ia=web
    - https://www.ablebits.com/office-addins-blog/excel-concatenate-strings-cells-columns/

1. Duplicate the metadata file for the first video and rename the file `stuzkova.m4v.metadata.txt`

1. Add the metadata for second DVD video with recalculated chapter times to the metadata file `stuzkova.m4v.metadata.txt` for completeness.

    [Example file](res/stuzkova.m4v.metadata.txt) of merged original metadata from DVD 1 and shifted metadata for DVD2

1. Integrate final metadata into the concatenated video

        ffmpeg -i stuzkova.mkv -i stuzkova.m4v.metadata.txt -map_metadata 1 -map_chapters 1 -codec copy stuzkova-WITH_CHAPTERS.mkv
