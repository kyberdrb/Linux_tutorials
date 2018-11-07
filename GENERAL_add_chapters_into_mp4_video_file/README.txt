1. Go to the directory, e.g. on USB, with complete video file and chapter metadata file:

        cd /run/media/andrej/EEFC5F97FC5F58C3/dopravne_situacie/dopravne_situacie_bez_komentara/final/

2. Add chapters to the video file:

        ffmpeg -i /run/media/andrej/EEFC5F97FC5F58C3/dopravne_situacie/dopravne_situacie_bez_komentara/final/dopravne_situacie_bez_komentara-vlc-bez_kapitol.mp4 -f ffmetadata -i /run/media/andrej/EEFC5F97FC5F58C3/dopravne_situacie/dopravne_situacie_bez_komentara/final/chapters_metadata.txt /run/media/andrej/EEFC5F97FC5F58C3/dopravne_situacie/dopravne_situacie_bez_komentara/final/dopravne_situacie_bez_komentara.mp4

3. Play the final video in a video player. _VLC media player_ is recommended.