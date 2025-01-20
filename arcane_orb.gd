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
	$spellDuration.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = point.global_position
	rotation = player_node.rotation
	direction = player_node.player_direction
	
	if(Globals.buffArcane and !Globals.buffPhysical):
		$AnimatedSprite2D.animation = "1"
	if(Globals.buffPhysical and !Globals.buffArcane):
		$AnimatedSprite2D.animation = "2"
	if(Globals.buffPhysical and Globals.buffArcane):
		$AnimatedSprite2D.animation = "3"
	#$AnimatedSprite2D2.play("default")

func selectBuffType(type: int) -> void:
	match type:
		#Arcane Buff
		1:
			Globals.arcaneDamageModifier += modifierArcane
			if(Globals.arcaneDamageModifier > Globals.MAX_arcaneDamageModifier):
				Globals.buffArcane = true
		2:
			Globals.physicalDamageModifier += modifierPhysical
			if(Globals.physicalDamageModifier > Globals.MAX_physicalDamageModifier):
				Globals.buffPhysical = true
	
func _on_spell_duration_timeout() -> void:
	match buffType:
		1:
			Globals.arcaneDamageModifier -= modifierArcane
			
			if(Globals.arcaneDamageModifier <= Globals.MAX_arcaneDamageModifier):
				Globals.buffArcane = false
		2:
			Globals.physicalDamageModifier -= modifierPhysical
			
			if(Globals.physicalDamageModifier <= Globals.MAX_physicalDamageModifier):
				Globals.buffPhysical = false
	queue_free()
