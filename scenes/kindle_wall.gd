extends Area2D

@export var speed: int = 0

var direction: Vector2 = Vector2.UP
var player_node: CharacterBody2D = null
#var direction = (get_global_mouse_position() - position).normalized()

var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var point = player_node.get_node("CastPoint")
	position = point.global_position
	rotation = point.global_rotation
	$spellDuration.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player": #can also use "if "hit" in body:"
		if body.has_method("hit"):
			body.hit(damage)

func _on_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.

func _on_spell_duration_timeout() -> void:
	queue_free()
