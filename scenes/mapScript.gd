extends Node2D
var wolf_scene: PackedScene = preload("res://scenes/wolf.tscn") #Make sure ending is .tscn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Setting Player Starting Position:")
	$Player.position.x = 500
	$Player.position.y = 250


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_player_enemy_spawner_signal(pos: Variant) -> void:
	print("Spawning Wolf...")
	#creating instance of a wolf
	var wolf = wolf_scene.instantiate()
	wolf.position = pos
	#wolf.look_at($Player.global_position)
	add_child(wolf)
