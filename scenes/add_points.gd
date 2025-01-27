extends CanvasLayer

var canLeaveMenu: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Temporary code: Displaying SkillPoints:
	$"temporaryLabel-SkillPoint".text = "SKILL POINTS: " + str(Globals.skill_points)
	if(Input.is_action_just_pressed("Tab") and canLeaveMenu):
			get_tree().paused = false
			canLeaveMenu = false
			$".".visible = false
			pass
	elif(get_tree().paused == true and $"../LevelUpScreen".visible == false):
		canLeaveMenu = true

#Health Button
func _on_button_pressed() -> void:
	if Globals.skill_points > 0:
		Globals.skill_points -= 1 #uses the skill point
		#increases max health by 1
		Globals.max_health_amount += 1
		Globals.health_amount += 1
		#updates UI health displayed
		$"../UI".update_health_amount()
		$Stats/health.text = "Health: " + str(Globals.max_health_amount)
