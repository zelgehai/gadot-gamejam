extends Area2D

@export var speed: int = 0
var direction: Vector2 = Vector2.UP
var player_node: CharacterBody2D = null
#var direction = (get_global_mouse_position() - position).normalized()

var point = null
var rotation_speed = .1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point = player_node.get_node("SelfPoint")
	position = point.global_position
	rotation = point.global_rotation
	direction = player_node.player_direction
	Globals.Invulnerable = true
	$spellDuration.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = point.global_position
	rotation = player_node.rotation
	direction = player_node.player_direction

func _on_spell_duration_timeout() -> void:
	Globals.Invulnerable = false
	queue_free()
