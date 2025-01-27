extends CanvasLayer

@onready var health_label: Label = $healthCounter/Label
@onready var health_bar:  = $healthCounter/healthBar
#colors
#var red: Color = Color(0.9,0,0,1)
func _ready() -> void:
	health_bar.max_value = Globals.max_health_amount
	health_bar.min_value = 0
	health_bar.value = Globals.health_amount
	
func update_health_amount():
	health_label.text = "Health: " + str(Globals.health_amount)
	health_bar.max_value = Globals.max_health_amount
	health_bar.value = Globals.health_amount
	

func update_expTracker(xp):
	Globals.player_experience += xp
	$expTracker/Label.text = "Exp= "+str(Globals.player_experience)
	$expTracker/Level.text = "Level= "+str(Globals.player_level)
	#calculate exp percentage to next level
	var percentage = int((Globals.player_experience / Globals.experienceNeeded) * 100)
	percentage = min(percentage, 100 ) #Cap at 100%
	$expTracker/lvlPercentage.text = str(percentage) + "%"
	
	if(Globals.player_experience > Globals.experienceNeeded):
		Globals.player_experience = 0
		Globals.player_level += 1
		Globals.skill_points += 1
		$expTracker/Label.text = "Exp= "+str(Globals.player_experience)
		$expTracker/Level.text = "Level= "+str(Globals.player_level)
		Globals.experienceNeeded = Globals.experienceNeeded*Globals.experienceGrowthRate
		
func addCardScreen() -> void:
		get_tree().paused = true
		call_deferred("addCard")

func addCard() -> void:
	get_tree().paused = true
	$"../LevelUpScreen".randomizeValues()
	$"../LevelUpScreen".visible = true
	
