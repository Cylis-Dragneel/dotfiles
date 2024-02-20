#!/bin/sh

#directory = $(cd ~/ && fzf)

#Getting to desired git repository
cd ~/Documents/Obsidian/

git add .
git commit -m "Changes Made"
git push origin main

