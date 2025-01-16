extends Area2D

@export var speed: int = 2000
var direction: Vector2 = Vector2.UP
#var direction = (get_global_mouse_position() - position).normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print('minibolt direction:')
	print(direction)
	position += direction * speed * delta
	
