#!/bin/zsh

# Enable extended globbing
setopt extended_glob

# Define the directory to clean
downloads_folder="$HOME/Downloads"

# Step 1: Move files to appropriate folders based on extensions
echo "Moving files to appropriate folders..."

# Move PDF and EPUB files to Documents
mv -v "$downloads_folder"/*.(pdf|epub) "$HOME/Documents/"

# Move image files to Pictures
mv -v "$downloads_folder"/*.(png|jpg|jpeg|gif) "$HOME/Pictures/"

# Move video files to Videos
mv -v "$downloads_folder"/*.(webm|mp4|mkv) "$HOME/Videos/"

# Move MP3 files to Music
mv -v "$downloads_folder"/*.mp3 "$HOME/Music/"

# Move archive files to Downloads/Archives
mv -v "$downloads_folder"/*.(7z|tar|zip) "$HOME/Downloads/Archives/"

# Step 2: Identify files larger than 500 MB
echo "Identifying files larger than 500 MB..."
du -h "$downloads_folder"/*(L+500M) | awk '$1 ~ /M$/ { print $2 }'

# Ask user for action on large files
echo -n "Do you want to delete all large files? (yes/no): "
read delete_all

if [ "$delete_all" = "yes" ]; then
    echo "Deleting all large files..."
    rm -v "$downloads_folder"/*(L+500M)
elif [ "$delete_all" = "no" ]; then
    destination_folder="$HOME/Documents/"
    echo "Files larger than 500 MB:"
    du -h "$downloads_folder"/*(L+500M) | awk '$1 ~ /M$/ { print $2 }'
    echo -n "Enter the file names you want to keep (separated by spaces): "
    read files_to_keep
    echo "Moving selected files to $destination_folder..."
    for file in $files_to_keep; do
        mv -v "$downloads_folder/$file" "$destination_folder"
    done
else
    echo "No action taken on large files."
fi

echo "Cleanup complete!"

