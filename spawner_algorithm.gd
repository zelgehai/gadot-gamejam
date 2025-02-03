extends Node2D

#[Dictionaries within a List] of all the mob_types and their spawn rates
#Scene = [path to mob scene] , spawn_rate = [x%]
#SPAWN RATE VALUES DONT HAVE TO ADD UP TO 100!!! 
var mob_types = [
	{ "name": "wolf", "scene": preload("res://scenes/enemies/wolf.tscn"), "spawn_rate": 100},
	{ "name": "direWolf", "scene": preload("res://scenes/direWolf.tscn"), "spawn_rate": 10},
	{ "name": "ogre", "scene": preload("res://scenes/enemies/ogre.tscn"), "spawn_rate": 1},
	{ "name": "wisp", "scene": preload("res://scenes/wisp.tscn"), "spawn_rate": 20},
	{ "name": "greater_wisp", "scene": preload("res://scenes/greater_wisp.tscn"), "spawn_rate": 10},
	{ "name": "bombrat", "scene": preload("res://scenes/enemies/bomb_rat.tscn"), "spawn_rate": 15},
	{ "name": "raven", "scene": preload("res://scenes/enemies/raven.tscn"), "spawn_rate": 20},
	{ "name": "bigSlime", "scene": preload("res://scenes/enemies/big_slime.tscn"), "spawn_rate": 20},
	{ "name": "rockGiant", "scene": preload("res://scenes/enemies/rock_giant.tscn"), "spawn_rate": 1},
]
var mob_count = {} #Dictionary to track count of each mob type

func get_random_mob():
	var total_weight = 0
	for mob in mob_types:
		total_weight += mob.spawn_rate #sums up all the spawn rates
	var rand_value = randi() % total_weight #Pick a number within the "range"
	
	var cumulative = 0
	for mob in mob_types:
		cumulative += mob.spawn_rate
		if rand_value < cumulative:
			return mob #returns the whole dictionary
