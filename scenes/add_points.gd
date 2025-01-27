extends CanvasLayer

var canLeaveMenu: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Tab") and canLeaveMenu):
			get_tree().paused = false
			canLeaveMenu = false
			$".".visible = false
			pass
	elif(get_tree().paused == true and $"../LevelUpScreen".visible == false):
		canLeaveMenu = true
