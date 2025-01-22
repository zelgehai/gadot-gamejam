extends Control

func _on_button_pressed() -> void:
	print("Restarting Game...")
	get_node("/root/Globals").reset_values() #reset Global Values
	get_tree().change_scene_to_file("res://scenes/map.tscn")
