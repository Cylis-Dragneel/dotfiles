#!/bin/sh

#Determine size of download
read -p "Is the file being downloaded large? (yes/no): " download_size

#Specify Download Location
if [ "$download_size" = "yes" ]; then
	target_directory="/media/taha/Games/IDM Game Downloads/Down"
else
	target_directory="$HOME/Downloads/aria"
fi

cd "$target_directory"

#Input download link
read -p "Enter link of the file: " link 

#Downloads file
aria2c -x16 "$link"

#Gets file name
echo "Files in directory:"
ls
read -p "Enter the name of file to process: " file_name
download_directory="/media/taha/Games/IDM Game Downloads/"
#Checks if file is an archive
if echo "$target_directory/$file_name" | grep -qE '\.t(ar\.gz|gz|ar\.xz|bz2|ar\/zst)$'; then
	#Extracts tarball
	if ["$download_size" = "yes"]; then
		tar -xvf "$file_name" -C "$download_dirrectory"
	else
		tar -xvf "$file_name"
	fi
elif echo "$target_directory/$file_name" | grep -qE '\.zip$'; then
	#Extracts zip
	if ["$download_size" = "yes"]; then
		unzip "$file_name" -d "$download_directory"
	else
		unzip "$file_name"
	fi
else
	echo "File downloaded is not an archive"
fi

echo "Fin"
