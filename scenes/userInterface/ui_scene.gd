extends CanvasLayer

@onready var health_label: Label = $Control/VBoxContainer/Label

func update_health_amount():
	health_label.text = str(Globals.health_amount)
