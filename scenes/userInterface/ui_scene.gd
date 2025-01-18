extends CanvasLayer

@onready var health_label: Label = $healthCounter/Label
@onready var health_bar:  = $healthCounter/healthBar
#colors
#var red: Color = Color(0.9,0,0,1)

func update_health_amount():
	health_label.text = "Health: " + str(Globals.health_amount)
	health_bar.value = Globals.health_amount
	
