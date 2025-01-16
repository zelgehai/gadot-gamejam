extends CharacterBody2D
var inside = false
var canPrint = true
var player_node: CharacterBody2D = null #reference to the player node
var direction_to_player = Vector2(1,0)
var speed = 100
var randomized_speed = 1

func _ready() -> void:
	direction_to_player = (player_node.global_position - global_position).normalized()
	randomized_speed = (randi() % 250 + speed) # Random num from speed -> 500
	
func _process(_delta: float) -> void:
	if player_node:
		#get directions towards the player [ to know to face it]
		direction_to_player = (player_node.global_position - global_position).normalized()
		velocity = direction_to_player * randomized_speed #moves toward player
		move_and_slide()
		
		look_at(player_node.global_position)
		rotation += deg_to_rad(90)
		
	
	if canPrint and inside:
			print('Body has entered')
			canPrint = false
			$Timer.start()

func hit():
	print('damage')
	queue_free() #Deletes wolf when hit
	
func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	inside = true

func _on_area_2d_body_exited(_body: CharacterBody2D) -> void:
	inside = false
	
func _on_timer_timeout() -> void:
	canPrint = true
