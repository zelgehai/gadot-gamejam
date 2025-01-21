extends Area2D

var buffType = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(_body: Node2D) -> void:
	match buffType:
		1:
			print("Player picked up Physical Buff")
			call_deferred("pushBuff")
			call_deferred("queue_free")	
		2:
			print("Player picked up Elemental Buff")
			call_deferred("pushBuff")
			call_deferred("queue_free")
		3:
			print("Player picked up Arcane Buff")
			call_deferred("pushBuff")
			call_deferred("queue_free")
	
func pushBuff() -> void:
	Globals.spawnArcaneOrb(buffType)
