#!/bin/bash

# implement the cli
copy=false # a boolean to make the flag `output` optional

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -l|--list) # this should be the list file that we want searched 
            if [[ -n "$2" ]]; then
                the_list="$2"
                shift
            else
                echo "Error: --list requires a value"
                exit 1
            fi
            ;;
        -s|--search) # the location where the search should be performed
            if [[ -n "$2" ]]; then
                the_search_path="$2"
                shift
            else
                echo "Error: --the_search_path requires a value"
                exit 1
            fi
            ;;
        -o|--output) # the output directory where files should be copied (optional)
            if [[ -n "$2" ]]; then
                output_path="$2"
                copy=true
                shift
            fi
            ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

# Check if the search path actually exits, if not then drop it.
if ! [ -d "$the_search_path" ]; then
    echo "Does the provided path $ the_search_path exist?"
    exit 1
fi

# check if the copy variable is true, if so then check if the output path, exits, if it does use it else create it.

if [[ "$copy" == true ]]; then
    if [[ -d "$output_path" ]]; then
        echo "Output directory exists: $output_path"
    else
        echo "Output directory does not exist. Creating: $output_path"
        mkdir -p "$output_path"
    fi
    
    # Perform the copying operation here
    echo "Copying files to: $output_path"
fi

# Check if the input file exists and is not empty
if [[ ! -s "$the_list" ]]; then
    echo "Error: Input file is empty or does not exist"
    exit 1
fi

# Parse the input file and copy the matching files
while IFS= read -r line; do
    matching_files=$(find "$the_search_path" -type f -iname "*$line*")
    
    if [[ -n "$matching_files" ]]; then
        if [[ "$copy" == true ]]; then
            cp $matching_files "$output_path"
            echo "Copied matching files for '$line' to $output_path"
        else
            echo "Matching files for '$line':"
            echo "$matching_files"
        fi
    else
        echo "No matching files found for '$line'"
    fi
    
done < "$the_list"
