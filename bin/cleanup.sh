#!/bin/zsh

# Define the directory to clean
downloads_folder="$HOME/Downloads"
cd "$downloads_folder"

# Step 1: Move files with specific extensions to appropriate folders
echo "Moving files to appropriate folders..."
mv *.pdf *.epub home/taha/Documents
mv *.jpeg *.jpg *.png home/taha/Documents
mv *.webm *.mp4 *.mkv home/taha/Videos
mv *.mp3 home/taha/Music
mv *.7z *.zip *.tar.* home/taha/Downloads/Archives

# Step 2: Identify files larger than 500 MB
echo "Identifying files larger than 500 MB..."
du -h "$downloads_folder"/*(L+500M) | awk '$1 ~ /M$/ { print $2 }'

# Ask user for action on large files
read -p "Do you want to delete all large files? (yes/no): " delete_all

if [ "$delete_all" = "yes" ]; then
    echo "Deleting all large files..."
    find "$downloads_folder" -type f -size +500M -delete
elif [ "$delete_all" = "no" ]; then
    read -p "Enter the file names you want to keep (separated by spaces): " files_to_keep
    echo "Moving selected files to another location..."
    for file in $files_to_keep; do
        mv "$downloads_folder/$file" "$HOME/Documents/"
    done
else
    echo "No action taken on large files."
fi

echo "Cleanup complete!"

