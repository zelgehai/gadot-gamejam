extends Node

#var  = true
var elapsed_time = 0

#AutoAttack timer modifier
var attackSpeed: float = .25

#Deck List: Starts empty,can grow to any size, discard starts at zero gets bigger when discard
var DECK_LIST: Array = []
var DISCARD_LIST: Array = []

#Player Variables
var health_amount = 10 #current health of the player
var max_health_amount = 10 #Should be the same as Starting Health, Game level Stats Increase this
var Invulnerable = false
var player_experience = 0
var player_level = 0
var skill_points = 0   #skill points earned when leveled


#Level Up Map
var experienceNeeded = 1
var experienceGrowthRate = 1.5

#Mob Variables
var max_enemies_allowed = 500 #number of enemies allowed to be in the map / spawned
var current_enemies_alive = 0 #number of enemies alive currently

#Spawn Rates: # represents % chance. VALUES MUST ALL ADD TO 100!
var wolf_Spawn_Rate = 40 	#40 10 1 10 5 10 8 15 1
var dire_Spawn_Rate = 10
var ogre_Spawn_Rate = 1
var wisp_Spawn_Rate = 10
var greater_wisp_Spawn_Rate = 5
var bombrat_Spawn_Rate = 10
var raven_Spawn_Rate = 8
var bigSlime_Spawn_Rate = 15
var rockGiant_Spawn_Rate = 1

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
var MiniBolt: PackedScene = preload("res://scenes/cards/MiniBolt.tscn")
var Slash: PackedScene = preload("res://scenes/cards/slash.tscn")
var Block: PackedScene = preload("res://scenes/cards/block.tscn")
var KindleWall: PackedScene = preload("res://scenes/cards/kindle_wall.tscn")
var wisp_Spell: PackedScene = preload("res://scenes/wisp_spell.tscn")
var greater_wisp_spell: PackedScene = preload("res://scenes/greater_wisp_spell.tscn")
var ratBomb_Spell: PackedScene = preload("res://graphics/projectiles/bomb.tscn")
var rock_spell: PackedScene = preload("res://graphics/projectiles/rock_spell.tscn")
#Effects from Drops
var ArcaneOrb: PackedScene = preload("res://scenes/cards/arcane_orb.tscn")
var ArcaneDash: PackedScene = preload("res://scenes/cards/arcane_dash.tscn")

#Enemy Scenes
var wolf_scene: PackedScene = preload("res://scenes/enemies/wolf.tscn") #Make sure ending is .tscn
var direWolf_scene: PackedScene = preload("res://scenes/enemies/direWolf.tscn")
var ogre_scene: PackedScene = preload("res://scenes/enemies/ogre.tscn")
var wisp_scene: PackedScene = preload("res://scenes/enemies/wisp.tscn")
var greater_wisp_scene: PackedScene = preload("res://scenes/enemies/greater_wisp.tscn")
var bombrat_scene: PackedScene = preload("res://scenes/enemies/bomb_rat.tscn")
var raven_scene: PackedScene = preload("res://scenes/enemies/raven.tscn")
var bigSlime_scene: PackedScene = preload("res://scenes/enemies/big_slime.tscn")
var smallSlime_scene: PackedScene = preload("res://scenes/enemies/small_slime.tscn")
var rockGiant_scene: PackedScene = preload("res://scenes/enemies/rock_giant.tscn")
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
	
func updateAttackSpeed(value: float) -> void:
	attackSpeed += value
	$"../map/miniBoltTimer".wait_time = attackSpeed
	
#This func is called in death_scene.gd, to reset player values for game restart
func reset_values() -> void:
	elapsed_time = 0
	health_amount = 10 #current health of the player
	max_health_amount = 20 #Maximum health, stats can increase this
	Invulnerable = false
	player_experience = 0
	#Mob Variables
	max_enemies_allowed = 500 #number of enemies allowed to be in the map / spawned
	current_enemies_alive = 0 #number of enemies alive currently
	#Spawn Rates: # represents % chance. VALUES MUST ALL ADD TO 100!
	wolf_Spawn_Rate = 40 
	dire_Spawn_Rate = 10
	ogre_Spawn_Rate = 1
	wisp_Spawn_Rate = 10
	greater_wisp_Spawn_Rate = 5
	bombrat_Spawn_Rate = 10
	raven_Spawn_Rate = 8
	bigSlime_Spawn_Rate = 15
	rockGiant_Spawn_Rate = 1
	#Spell Modifiers
	arcaneDamageModifier = 1.00
	elementalDamageModifier = 1.00
	physicalDamageModifier = 1.00
	speedModifier = 1.00
	MAX_arcaneDamageModifier = 1.00
	MAX_elementalDamageModifier = 1.00
	MAX_physicalDamageModifier = 1.00
	MAX_speedModifier = 1.00
