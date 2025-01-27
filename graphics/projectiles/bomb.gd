extends Area2D

@export var speed: int = 250 #Speed of the Wisp Pellet
var direction: Vector2 = Vector2.UP
var player_node: CharacterBody2D = null
var direction_to_player = Vector2(1,0)
var rat_node: CharacterBody2D = null
#Damage Output
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = rat_node.global_position
	#rotation = point.global_rotation
	rotation = direction_to_player.angle()
	$spellDuration.start()

	
#Bomb 
func _on_body_entered(body):
	if body.name == "Player":
		Globals.damage_Player(damage)
		body.player_hit()
		queue_free()
	
func _on_spell_duration_timeout() -> void:
	queue_free()
