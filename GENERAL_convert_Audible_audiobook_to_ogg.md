	git clone git@github.com:inAudible-NG/tables.git

	cd tables/

	ffprobe ~/Downloads/AudibleAudiobookFile.aax

Find `file checksum` field

		libpostproc    55.  3.100 / 55.  3.100
		[mov,mp4,m4a,3gp,3g2,mj2 @ 0x55b57d294640] [aax] file checksum == 20708ea4a4d3915193b21e068c63ae840e1c1fab
		[mov,mp4,m4a,3gp,3g2,mj2 @ 0x55b57d294640] [aax] activation_bytes option is missing!

	./rcrack . -h 20708ea4a4d3915193b21e068c63ae840e1c1fab

	ffmpeg -activation_bytes de357214 -i ~/Downloads/AudibleAudiobookFile.aax -vn -c:a libvorbis ~/Downloads/AudibleAudiobookFile.ogg

Sources:

https://wiki.archlinux.org/index.php/Audiobook#Audible_format

https://github.com/inAudible-NG/tables

https://superuser.com/questions/273797/convert-mp3-to-ogg-vorbis/584177#584177

