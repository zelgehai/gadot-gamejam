extends Area2D

#BuffType Map
# 1 = Physical
#2 = Elemental
#3 = Arcane
#4 = Speed
#5 = Health
var buffType = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(buffType == 1):
		$AnimatedSprite2D.animation = str(buffType)
	if(buffType == 2):
		$AnimatedSprite2D.animation = str(buffType)
	if(buffType == 3):
		$AnimatedSprite2D.animation = str(buffType)
	if(buffType == 4):
		$AnimatedSprite2D.animation = str(buffType)
	if(buffType == 5):
		$AnimatedSprite2D.animation = str(buffType)
	if(buffType == 6):
		$AnimatedSprite2D.animation = str(buffType)

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
		4:
			print("Player picked up Speed Buff")
			call_deferred("pushBuff")
			call_deferred("queue_free")
		5:
			print("Player picked up Health Buff")
			call_deferred("pushBuff")
			call_deferred("queue_free")
		6:
			print("Player picked up Card Addition Buff")
			call_deferred("pushBuff")
			call_deferred("queue_free")
	
func pushBuff() -> void:
	Globals.spawnArcaneOrb(buffType)
