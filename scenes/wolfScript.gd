extends CharacterBody2D
var inside = false
var canPrint = true

func _process(_delta: float) -> void:
	if canPrint and inside:
			print('Body has entered')
			canPrint = false
			$Timer.start()

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	inside = true

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	inside = false
	
func _on_timer_timeout() -> void:
	canPrint = true
	
	#creating Instance
	
