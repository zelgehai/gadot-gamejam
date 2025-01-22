extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	#update timer
	update_timer_label()

func update_timer_label() -> void:
	$TimerLabel.text = format_time(Globals.elapsed_time)

func _on_timer_timeout() -> void:
	Globals.elapsed_time += 1 #increment timer by 1 every second
	update_timer_label()
	
func format_time(seconds: int) -> String:
	var minutes = seconds/60
	var hours = minutes/60
	if hours > 0:
		return "%02d:%02d:%02d" % [hours, minutes % 60, seconds % 60]
	else:
		return "%02d:%02d" % [minutes, seconds % 60]
