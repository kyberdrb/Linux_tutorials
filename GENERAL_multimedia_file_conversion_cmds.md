
## Convert

        ffmpeg -i NonViolent\ Compassionate\ Communication\ A\ Language\ of\ Life\ Marshall\ Rosenberg\ AUDIOBOOK-CBZUpt1bmnM.webm -vn -y NonViolent\ Compassionate\ Communication\ A\ Language\ of\ Life\ Marshall\ Rosenberg\ AUDIOBOOK-CBZUpt1bmnM.ogg

## Cut

        ffmpeg -ss "11:23:16.000" -to "11:53:28.000" -i /home/laptop/Desktop/Lehrmaterialien/2_done/Effective_Communication_Skills-Dalton_Kehoe/EffectiveCommunicationSkills_ep6_Audible.ogg /home/laptop/Desktop/Lehrmaterialien/2_done/Effective_Communication_Skills-Dalton_Kehoe/EffectiveCommunicationSkills_ep6_chapter_24.ogg

## Batch convert

        parallel 'ffmpeg -i "{}" -c:a libvorbis -vn -b:a 64k -y "{.}.ogg"' ::: $(ls *.m4v)
        (https://gist.github.com/Brainiarc7/18fca697891aea0e879f13ed092cb213)

**Note:** Before running `parallel`, make sure the file name contains only alphanumeric characters and symbols.
The file name mustn't contain white characters, like spaces, unique language characters, like 'ö', 'ä', 'ß' etc.
Otherwise `parallel` splits the filename and treats them as multiple files which produces and error message 
or it ignores them altogether
