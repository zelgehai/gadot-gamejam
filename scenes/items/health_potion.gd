extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("Player picked up Potion")
	if Globals.health_amount < Globals.max_health_amount:
		Globals.health_amount += 1
		$"../../UI".update_health_amount()
		queue_free()
		
		
func spawn_healthpot():
	print("spawning Health_potion")
