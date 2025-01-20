extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(_body: Node2D) -> void:
	print("Player picked up Health Potion")
	call_deferred("queue_free")
	if Globals.health_amount < Globals.max_health_amount:
		Globals.health_amount += 1
		$"../../UI".update_health_amount()
