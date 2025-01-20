extends CharacterBody2D
var player_direction = Vector2(1,0)
# Called when the node enters the scene tree for the first time.
#Health Value at Start:

func _ready() -> void:
	player_direction = (get_global_mouse_position() - position).normalized()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	player_direction = (get_global_mouse_position() - position).normalized()
	#input
	var direction = Input.get_vector("left","right","up", "down")
	velocity = direction  * 400
	move_and_slide()
	

func player_hit():
	print("Player was HIT, Health = ", Globals.health_amount)
	$"../UI".update_health_amount()
	
func giveDirection() -> Vector2:
	return player_direction
