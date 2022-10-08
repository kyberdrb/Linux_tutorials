1. Go to the directory, e.g. on USB, with complete video file and chapter metadata file:

        cd /run/media/andrej/EEFC5F97FC5F58C3/dopravne_situacie/dopravne_situacie_bez_komentara/final/

1. Add chapters to the video file:

        ffmpeg -i /run/media/andrej/EEFC5F97FC5F58C3/dopravne_situacie/dopravne_situacie_bez_komentara/final/dopravne_situacie_bez_komentara-vlc-bez_kapitol.mp4 -f ffmetadata -i /run/media/andrej/EEFC5F97FC5F58C3/dopravne_situacie/dopravne_situacie_bez_komentara/final/chapters_metadata.txt /run/media/andrej/EEFC5F97FC5F58C3/dopravne_situacie/dopravne_situacie_bez_komentara/final/dopravne_situacie_bez_komentara.mp4

1. Play the final video in a video player. _VLC media player_ is recommended.

# Sources
https://forum.videohelp.com/threads/383290-Adding-subs-and-chapters-to-mp4

https://stackoverflow.com/questions/47415660/how-to-add-chapters-into-mp4-mkv-file-using-ffmpeg/47415805#47415805

https://ffmpeg.org/ffmpeg-formats.html#Metadata-1

http://p.cweiske.de/290

https://stackoverflow.com/questions/9464617/retrieving-and-saving-media-metadata-using-ffmpeg/9473239#9473239

https://stackoverflow.com/questions/11706049/converting-video-formats-and-copying-tags-with-ffmpeg/11706693#11706693

https://wiki.videolan.org/VLC_HowTo/Merge_videos_together/

https://stackoverflow.com/questions/47415660/how-to-add-chapters-into-mp4-mkv-file-using-ffmpeg#comment81787662_47415660

https://www.tools4noobs.com/online_tools/hh_mm_ss_to_seconds/

https://www.tools4noobs.com/online_tools/seconds_to_hh_mm_ss/


https://wiki.videolan.org/Documentation:Streaming_HowTo/Advanced_Streaming_Using_the_Command_Line/#mux_2