extends Area2D

@export var speed: int = 0
var direction: Vector2 = Vector2.UP
var player_node: CharacterBody2D = null
#var direction = (get_global_mouse_position() - position).normalized()

#Buff Types
var buffType = 1
#Modifier amount for given stat (Arcane)
var modifierArcane = .3
var modifierPhysical = .3
var modifierElemental = .3
var modifierSpeed = .1
var modifierHealth = 2

#Node for Player
var point = null
var rotation_speed = .1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point = player_node.get_node("SelfPoint")
	position = point.global_position
	rotation = point.global_rotation
	direction = player_node.player_direction
	selectBuffType(buffType)
	if(buffType == 1):
		$AnimatedSprite2D.animation = "1"
	if(buffType == 2):
		$AnimatedSprite2D.animation = "2"
	if(buffType == 3):
		$AnimatedSprite2D.animation = "3"
	if(buffType == 4):
		$AnimatedSprite2D.animation = "8"
	if(buffType == 5):
		$AnimatedSprite2D.animation = "9"
		$spellDuration.wait_time = 1
	if(buffType == 6):
		$AnimatedSprite2D.animation = "9"
	$spellDuration.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = point.global_position
	rotation = player_node.rotation
	direction = player_node.player_direction
	if(buffType == 1 or buffType == 2 or buffType == 3):
		if(!Globals.buffArcane and !Globals.buffElemental and Globals.buffPhysical):
			$AnimatedSprite2D.animation = "1"
		if(!Globals.buffArcane and Globals.buffElemental and !Globals.buffPhysical):
			$AnimatedSprite2D.animation = "2"
		if(Globals.buffArcane and !Globals.buffElemental and !Globals.buffPhysical):
			$AnimatedSprite2D.animation = "3"
		if(Globals.buffArcane and !Globals.buffElemental and Globals.buffPhysical):
			$AnimatedSprite2D.animation = "4"
		if(Globals.buffArcane and Globals.buffElemental and !Globals.buffPhysical):
			$AnimatedSprite2D.animation = "5"
		if(!Globals.buffArcane and Globals.buffElemental and Globals.buffPhysical):
			$AnimatedSprite2D.animation = "6"
		if(Globals.buffArcane and Globals.buffElemental and Globals.buffPhysical):
			$AnimatedSprite2D.animation = "7"

func selectBuffType(type: int) -> void:
	match type:
		1:#Physical Buff
			Globals.physicalDamageModifier += modifierPhysical
			if(Globals.physicalDamageModifier > Globals.MAX_physicalDamageModifier):
				Globals.buffPhysical = true
			
		2:#Elemental Buff
			Globals.elementalDamageModifier += modifierElemental
			if(Globals.elementalDamageModifier > Globals.MAX_elementalDamageModifier):
				Globals.buffElemental = true
		3:#Arcane Buff
			Globals.arcaneDamageModifier += modifierArcane
			if(Globals.arcaneDamageModifier > Globals.MAX_arcaneDamageModifier):
				Globals.buffArcane = true
		
		4:#Speed Buff
			Globals.speedModifier += modifierSpeed
			if(Globals.speedModifier > Globals.MAX_speedModifier):
				Globals.buffSpeed = true
		5:#Health Buff
			Globals.health_amount = Globals.health_amount + 5
			$"../../UI".update_health_amount()
		6:
			#print("ADD CARD SCENE")
			$"../../UI".addCardScreen()
			#if(Globals.health_amount > Globals.max_health_amount):
				#Globals.health_amount = Globals.max_health_amount
	
func _on_spell_duration_timeout() -> void:
	match buffType:
		1:#Remove Physical Buff
			Globals.physicalDamageModifier -= modifierPhysical
			
			if(Globals.physicalDamageModifier <= Globals.MAX_physicalDamageModifier):
				Globals.buffPhysical = false
		2:#Remove Arcane Buff	
			Globals.elementalDamageModifier -= modifierElemental
			
			if(Globals.elementalDamageModifier <= Globals.MAX_elementalDamageModifier):
				Globals.buffElemental = false
		3:#Remove Elemental Buff
			Globals.arcaneDamageModifier -= modifierArcane
			
			if(Globals.arcaneDamageModifier <= Globals.MAX_arcaneDamageModifier):
				Globals.buffArcane = false
		4:#Remove Speed Buff
			Globals.speedModifier -= modifierSpeed
			
			if(Globals.speedModifier <= Globals.MAX_speedModifier):
				Globals.buffSpeed = false
		5:#Remove Health Buff (pass, No Animation)
			pass
		6: 
			pass
	queue_free()
