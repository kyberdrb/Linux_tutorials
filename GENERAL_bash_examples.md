Rename all files in current directory
- singlify duplicate characters, replace spaces and special characters with another character
- assuming there is no spaces in the path to the current working directory `pwd`

        for file in $(pwd)/*; do mv "$file" "$(echo "$(pwd)/$(basename "${file}")" | sed "s/['´]//g" | sed 's/[() ]/_/g' | sed 's/__/_/g')" ; done

        for file in $(pwd)/*; do mv "$file" "$(echo "${file}" | sed "s/['´]//g" | sed 's/[() ]/_/g' | sed 's/__/_/g')" ; done
