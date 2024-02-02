#!/bin/zsh
#Array with names
Games=("Nier: Automata" "RetroArch" "Sekiro" "Octopath Traveller II" "Sea of Stars" "Fuga: Melodies of Steel" "Pokemon Myth" "Kannagi Usagi" "Hollow Knight" "HoloCure" "Limbus Company" "Titan Souls" "Dark Souls 3" "Devil May Cry")
#Get the number of games
num_games=${#Games}

#Generate a random Game no.
random_index=$((RANDOM % num_games))

#Store the name of the game and output it
random_game=${Games[random_index]}

echo "Randomly selected game: $random_game"
