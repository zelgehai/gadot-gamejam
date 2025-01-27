extends CanvasLayer

@onready var health_label: Label = $healthCounter/Label
@onready var health_bar:  = $healthCounter/healthBar
#colors test
#var red: Color = Color(0.9,0,0,1)
func _ready() -> void:
	health_bar.max_value = Globals.max_health_amount
	health_bar.min_value = 0
	health_bar.value = Globals.health_amount
	
func update_health_amount():
	health_label.text = "Health: " + str(Globals.health_amount)
	health_bar.value = Globals.health_amount

func update_expTracker(exp):
	Globals.player_experience += exp
	$expTracker/Label.text = "Exp= "+str(Globals.player_experience)
	$expTracker/Level.text = "Exp= "+str(Globals.player_level)
	if(Globals.player_experience > Globals.experienceNeeded):
		Globals.player_experience = 0
		Globals.player_level += 1
		$expTracker/Label.text = "Exp= "+str(Globals.player_experience)
		$expTracker/Level.text = "Level= "+str(Globals.player_level)
		Globals.experienceNeeded = Globals.experienceNeeded*Globals.experienceGrowthRate
		get_tree().paused = true
		call_deferred("levelUp")
		
func levelUp() -> void:
	$"../LevelUpScreen".randomizeValues()
	$"../LevelUpScreen".visible = true
	
