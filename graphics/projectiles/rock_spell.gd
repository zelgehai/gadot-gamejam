extends Area2D

@export var speed: int = 250 #Speed of the Rock
var direction: Vector2 = Vector2.UP
var player_node: CharacterBody2D = null
var direction_to_player = Vector2(1,0)
var rockGiant_Node: CharacterBody2D = null
#Damage Output
var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction_to_player = (player_node.global_position - position).normalized()
	rotation = direction_to_player.angle()
	$spellDuration.start()

func _process(delta: float) -> void:
	position += direction_to_player * speed * delta
	
#Rock
func _on_body_entered(body):
	if body.name == "Player":
		Globals.damage_Player(damage)
		body.player_hit()
		queue_free()
	
func _on_spell_duration_timeout() -> void:
	queue_free()
