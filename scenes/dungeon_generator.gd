extends Node2D

#IN PROGRESS:
#Goal: Generate a random Dungeon Only using one line of code w/ Arguments
#Example: Generate_Dungeon(Level, Biome,map, SpawnRate%, Timelimit, etc)

#Dungeon Map Scenes:
const MAP_SCENES = {
	"default": preload("res://scenes/map.tscn"),
	"cave": preload("res://scenes/cave_map.tscn")
	#'Highway": preload("xxx")
}

#Function to Generate Dungeon. Paramenters: 
func Generate_Dungeon(map_type: String, spawn_rate: float, time_limit: int):
	print("Creating Dungeon with:\nmap_type:",map_type,"\nspawn_rate:", spawn_rate,"\ntime_limit:",time_limit)
