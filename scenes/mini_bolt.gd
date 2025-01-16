extends Area2D

@export var speed: int = 2000
var direction: Vector2 = Vector2.UP
#var direction = (get_global_mouse_position() - position).normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#starts timer
	$spellDuration.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_body_entered(body):
	if body.has_method("hit"): #can also use "if "hit" in body:"
		body.hit()
	queue_free()

func _on_spell_duration_timeout() -> void:
	queue_free()
