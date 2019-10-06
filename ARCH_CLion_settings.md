# CLion setup
- Do not import settings
- Accept license agreement
- Skip and set defaults
- Untick _Show tips on startup_

- Remove the file header from the beginning of the newly created files in `File -> Settings -> Editor -> File and Code Templates
    - _Files_ tab
        - C++ Class Header

            #[[#pragma]]# once

            ${NAMESPACES_OPEN}
            class ${NAME} {

            };
            ${NAMESPACES_CLOSE}
 
        - C Header File

            #[[#pragma]]# once

    - _Includes_ tab
        - C File Header`

            #if ($HEADER_COMMENTS)
            //
            // Created by $USER_NAME on ${DATE}.
            #if ($ORGANIZATION_NAME && $ORGANIZATION_NAME != "")
            // Copyright (c) $YEAR ${ORGANIZATION_NAME}#if (!$ORGANIZATION_NAME.endsWith(".")).#end All rights reserved.
            #end
            //
            #end

- Change code style for CMake
	- set all indentation levels to `4`

- Use numpad arrows to navigate
    - Set up new key bindings for `Up`, `Down`, `Left` and `Right` in `File -> Settings -> Keymap`

- Add Git key-bindings
	- Git Pull - Ctrl+Shift+P
	- Git Merge - Ctrl+Shift+M

### Plugins

- Markdown Navigator
- -IdeaVim-

#### IdeaVim configuration

- Reassign keyboard shortcut to toggle `Vim Emulator` to `Ctrl + Alt + V`, beacuse it may conflict with CLion's _Extract variable_ functionality.

- Disable notifications for IdeaVim plugin. Go to `File -> Settings -> Appearance and Behavior -> Notifications` find `ideavim` and `ideavim-sticky` and in the _Popup_ column set the value  to _No popup_.

## Sources

https://stackoverflow.com/questions/24370502/turning-off-created-by-stamp-when-generating-files-in-intellij/46048450#46048450

