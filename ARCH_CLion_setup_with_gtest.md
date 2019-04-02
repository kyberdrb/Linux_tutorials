# CLion setup
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

## Gtest setup - CLion

- Download/Clone Google Test from GitHub
- Create a new project in CLion named `google_test_probe`
- Create a directory named `lib` in the project's root directory

        mkdir -p ~/CLionProjects/google_test_probe/lib/googletest


- Copy the downloaded Google Test directory to the `lib` directory

        cp -r googletest/* ~/CLionProjects/google_test_probe/lib/googletest/

- Continue along with [this video tutorial](https://www.youtube.com/watch?v=M067vFQG7ZA). Slight modifications are needed.  
For full project see

## Sources

https://stackoverflow.com/questions/24370502/turning-off-created-by-stamp-when-generating-files-in-intellij/46048450#46048450

https://www.jetbrains.com/help/clion/creating-google-test-run-debug-configuration-for-test.html

https://www.jetbrains.com/help/clion/quick-cmake-tutorial.html

https://stackoverflow.com/questions/33638433/setup-google-test-in-clion/34558470#34558470

https://stackoverflow.com/questions/33638433/setup-google-test-in-clion/44870138#44870138

https://stackoverflow.com/questions/26030700/unit-testing-c-setup-and-teardown/26034482#26034482

https://meekrosoft.wordpress.com/2009/10/04/testing-c-code-with-the-googletest-framework/
