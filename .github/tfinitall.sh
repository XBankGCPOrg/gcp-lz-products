#!/bin/bash
# Specify the path to the folder containing Terraform modules
function init_modules() {
    # Loop through each subfolder recursively
    find . -type f -name 'main.tf' -exec dirname {} \; | sort -u | while read -r folder; do
    # Your specific block of shell code here
    echo "Processing folder: $folder"
    cd "$folder" || exit
    terraform init
    cd - || exit
    done
}
init_modules .