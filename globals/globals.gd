extends Node

#Player Variables
var health_amount = 7 #current health of the player
var max_health_amount = 7 #Maximum health, stats can increase this
var Invulnerable = false

#Type Modifiers
var arcaneDamageModifier = 1.00
var elementalDamageModifier = 1.00
var physicalDamageModifier = 1.00

var MAX_arcaneDamageModifier = 1.00
var MAX_elementalDamageModifier = 1.00
var MAX_physicalDamageModifier = 1.00

#Typing Rotation
var buffElemental = false
var buffArcane = false
var buffPhysical = false

#Packed Scenes
var MiniBolt: PackedScene = preload("res://scenes/MiniBolt.tscn")
var Slash: PackedScene = preload("res://scenes/slash.tscn")
var Block: PackedScene = preload("res://scenes/block.tscn")
var KindleWall: PackedScene = preload("res://scenes/kindle_wall.tscn")
#Effects from Drops
var ArcaneOrb: PackedScene = preload("res://scenes/arcane_orb.tscn")
var ArcaneDash: PackedScene = preload("res://scenes/cards/arcane_dash.tscn")

#Item Scene
var wolf_scene: PackedScene = preload("res://scenes/wolf.tscn") #Make sure ending is .tscn
var health_potion_scene: PackedScene = preload("res://scenes/items/HealthPotion.tscn")
var arcane_orb_scene: PackedScene = preload("res://scenes/items/drop_arcane_orb.tscn")

#Spawn Stuff
func spawn_item(num1: int, num2: int, pos: Vector2):
	if(num1 == 1):
		var ranRoll = randf_range(0,100)
		if(ranRoll <= num2):
			spawn_healthpot(pos)
	if(num1 == 2):
		var ranRoll = randf_range(0,100)
		if(ranRoll <= num2):
			spawn_arcaneorb(pos)
		
func spawn_healthpot(pos: Vector2):
	var HP = health_potion_scene.instantiate()
	var items_node = get_tree().get_root().get_node("map/items")
	items_node.call_deferred("add_child", HP)
	HP.global_position = pos
	print("spawning Health_potion")

func spawn_arcaneorb(pos: Vector2):
	var AO = arcane_orb_scene.instantiate()
	var items_node = get_tree().get_root().get_node("map/items")
	items_node.call_deferred("add_child", AO)
	AO.global_position = pos
	AO.buffType = randi() % 2 + 1
	print("spawning Arcane Orb")

func spawnMiniBolt() -> void:
	var MB = Globals.MiniBolt.instantiate() as Area2D
	MB.player_node = $"../map/Player"
	$"../map/Projectiles".add_child(MB)

func spawnSlash() -> void:
	var SL = Globals.Slash.instantiate() as Area2D
	SL.player_node = $"../map/Player"
	$"../map/Projectiles".add_child(SL)

func spawnBlock() -> void:
	var BK = Globals.Block.instantiate() as Area2D
	BK.player_node = $"../map/Player"
	$"../map/Projectiles".add_child(BK)

func spawnKindleWall() -> void:
	var KW = Globals.KindleWall.instantiate() as Area2D
	KW.player_node = $"../map/Player"
	$"../map/Projectiles".add_child(KW)

func spawnArcaneOrb(type: int) -> void:
	var AO = Globals.ArcaneOrb.instantiate() as Area2D
	AO.player_node = $"../map/Player"
	AO.buffType= type
	$"../map/Projectiles".add_child(AO)
	
func spawnArcaneDash() -> void:
	var AD = Globals.ArcaneDash.instantiate() as Area2D
	AD.player_node = $"../map/Player"
	$"../map/Projectiles".add_child(AD)
	
#General Functions
func damage_Player(dmg):
	health_amount -= dmg



#Type Modifiers Updates???
