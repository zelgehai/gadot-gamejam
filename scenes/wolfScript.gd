extends CharacterBody2D
var inside = false
var canPrint = true

func _process(_delta: float) -> void:
	var direction = Vector2.RIGHT
	velocity = direction * 100
	move_and_slide()
	
	if canPrint and inside:
			print('Body has entered')
			canPrint = false
			$Timer.start()

func hit():
	print('damage')
	queue_free()
	
func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	inside = true

func _on_area_2d_body_exited(_body: CharacterBody2D) -> void:
	inside = false
	
func _on_timer_timeout() -> void:
	canPrint = true
