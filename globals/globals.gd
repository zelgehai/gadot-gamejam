extends Node

var canShoot = true

var elapsed_time = 0
#Player Variables
var health_amount = 10 #current health of the player
var max_health_amount = 20 #Maximum health, stats can increase this
var Invulnerable = false

#Mob Variables

var max_enemies_allowed = 500 #number of enemies allowed to be in the map / spawned

var current_enemies_alive = 0 #number of enemies alive currently

#Spawn Rates: # represents % chance. VALUES MUST ALL ADD TO 100!
var wolf_Spawn_Rate = 70 
var dire_Spawn_Rate = 25
var ogre_Spawn_Rate = 5

#Type Modifiers
var arcaneDamageModifier = 1.00
var elementalDamageModifier = 1.00
var physicalDamageModifier = 1.00
var speedModifier = 1.00

var MAX_arcaneDamageModifier = 1.00
var MAX_elementalDamageModifier = 1.00
var MAX_physicalDamageModifier = 1.00
var MAX_speedModifier = 1.00

#Typing Rotation
var buffElemental = false
var buffArcane = false
var buffPhysical = false
var buffSpeed = false

#Packed Scenes
var MiniBolt: PackedScene = preload("res://scenes/MiniBolt.tscn")
var Slash: PackedScene = preload("res://scenes/slash.tscn")
var Block: PackedScene = preload("res://scenes/block.tscn")
var KindleWall: PackedScene = preload("res://scenes/kindle_wall.tscn")
#Effects from Drops
var ArcaneOrb: PackedScene = preload("res://scenes/arcane_orb.tscn")
var ArcaneDash: PackedScene = preload("res://scenes/cards/arcane_dash.tscn")

#Enemy Scenes
var wolf_scene: PackedScene = preload("res://scenes/wolf.tscn") #Make sure ending is .tscn
var direWolf_scene: PackedScene = preload("res://scenes/direWolf.tscn")
var ogre_scene: PackedScene = preload("res://scenes/ogre.tscn")
#Item Scene
var health_potion_scene: PackedScene = preload("res://scenes/items/HealthPotion.tscn")
var arcane_orb_scene: PackedScene = preload("res://scenes/items/drop_arcane_orb.tscn")

#setting default values [this is important for restarting game after death]

#Spawn Stuff
	
#num1 = itemType num2 = percentage (out of 100) pos = the spawn location
func spawn_item(num1: int, num2: int, pos: Vector2):
	var ranRoll = randf_range(0,100)
	
	if(ranRoll <= num2):
		spawn_arcaneorb(pos, num1)
			
func spawn_healthpot(pos: Vector2):
	var HP = health_potion_scene.instantiate()
	var items_node = get_tree().get_root().get_node("map/items")
	items_node.call_deferred("add_child", HP)
	HP.global_position = pos
	print("spawning Health_potion")

func spawn_arcaneorb(pos: Vector2, type: int):
	var AO = arcane_orb_scene.instantiate()
	var items_node = get_tree().get_root().get_node("map/items")
	items_node.call_deferred("add_child", AO)
	AO.global_position = pos
	AO.buffType = type
	print("spawning Arcane Orb")

func spawnMiniBolt() -> void:
	canShoot = true
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
	
#This func is called in death_scene.gd, to reset player values for game restart
func reset_values() -> void:
	elapsed_time = 0
	health_amount = 10 #current health of the player
	max_health_amount = 20 #Maximum health, stats can increase this
	Invulnerable = false
	#Mob Variables
	max_enemies_allowed = 500 #number of enemies allowed to be in the map / spawned
	current_enemies_alive = 0 #number of enemies alive currently
	#Spawn Rates: # represents % chance. VALUES MUST ALL ADD TO 100!
	wolf_Spawn_Rate = 70 
	dire_Spawn_Rate = 25
	ogre_Spawn_Rate = 5
	arcaneDamageModifier = 1.00
	elementalDamageModifier = 1.00
	physicalDamageModifier = 1.00
	speedModifier = 1.00
	MAX_arcaneDamageModifier = 1.00
	MAX_elementalDamageModifier = 1.00
	MAX_physicalDamageModifier = 1.00
	MAX_speedModifier = 1.00
