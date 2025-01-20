extends Node

#Player Variables
var health_amount = 22 #current health of the player
var max_health_amount = 22 #Maximum health, stats can increase this
var Invulnerable = false

#Packed Scenes
var MiniBolt: PackedScene = preload("res://scenes/MiniBolt.tscn")
var Slash: PackedScene = preload("res://scenes/slash.tscn")
var Block: PackedScene = preload("res://scenes/block.tscn")
var KindleWall: PackedScene = preload("res://scenes/kindle_wall.tscn")
var ArcaneDash: PackedScene = preload("res://scenes/cards/arcane_dash.tscn")

var wolf_scene: PackedScene = preload("res://scenes/wolf.tscn") #Make sure ending is .tscn
var health_potion_scene: PackedScene = preload("res://scenes/items/HealthPotion.tscn")

#Spawn Stuff
func spawn_item(num1: int, num2: int, pos: Vector2):
	if(num1 == 1):
		var ranRoll = randf_range(0,100)
		if(ranRoll <= num2):
			spawn_healthpot(pos)
		
func spawn_healthpot(pos: Vector2):
	var HP = health_potion_scene.instantiate()
	var items_node = get_tree().get_root().get_node("map/items")
	items_node.call_deferred("add_child", HP)
	HP.global_position = pos
	print("spawning Health_potion")

#General Functions
func damage_Player(dmg):
	health_amount -= dmg
