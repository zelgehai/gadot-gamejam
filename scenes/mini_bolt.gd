extends Area2D

@export var speed: int = 2000
var direction: Vector2 = Vector2.UP
var player_node: CharacterBody2D = null

#Type of Card
var type = "Arcane"

#Damage Output
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var point = player_node.get_node("CastPoint")
	position = point.global_position
	rotation = point.global_rotation
	direction = player_node.player_direction
	$spellDuration.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_body_entered(body):
	if body.name != "Player": #can also use "if "hit" in body:"
		if body.has_method("hit"):
			#print(damage*Globals.arcaneDamageModifier)
			#print(Globals.buffArcane)
			body.hit(damage*Globals.arcaneDamageModifier)
		queue_free()
	
func _on_spell_duration_timeout() -> void:
	queue_free()
