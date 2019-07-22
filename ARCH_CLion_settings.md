# CLion setup
- Do not import settings
- Accept license agreement
- Skip and set defaults
- Untick _Show tips on startup_

- Remove the file header from the beginning of the newly created files in `File -> Settings -> File and Code Templates -> Includes (tab) -> C File Header`

            #if ($HEADER_COMMENTS)
            //
            // Created by $USER_NAME on ${DATE}.
            #if ($ORGANIZATION_NAME && $ORGANIZATION_NAME != "")
            // Copyright (c) $YEAR ${ORGANIZATION_NAME}#if (!$ORGANIZATION_NAME.endsWith(".")).#end All rights reserved.
            #end
            //
            #end


- Use numpad arrows to navigate
    - Set up new key bindings for `Up`, `Down`, `Left` and `Right` in `File -> Settings -> Keymap`

### Plugins

- IdeaVim

## Sources

https://stackoverflow.com/questions/24370502/turning-off-created-by-stamp-when-generating-files-in-intellij/46048450#46048450

