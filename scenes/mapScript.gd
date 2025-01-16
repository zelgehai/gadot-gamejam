extends Node2D
var wolf_scene: PackedScene = preload("res://scenes/wolf.tscn") #Make sure ending is .tscn
var MiniBolt: PackedScene = preload("res://scenes/MiniBolt.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Setting Player Starting Position:")
	$Player.position.x = 500
	$Player.position.y = 350


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("mouseLeftClick")):
		spawnCard()

func spawnCard() -> void:
	var MB = MiniBolt.instantiate() as Area2D
	MB.position = $Player/CastPoint.global_position
	MB.rotation = $Player/CastPoint.global_rotation
	MB.direction = $Player.player_direction
	$Projectiles.add_child(MB)

func _on_player_enemy_spawner_signal(pos: Variant) -> void:
	print("Spawning Wolf...")
	#creating instance of a wolf
	var wolf = wolf_scene.instantiate()
	wolf.position = pos
	$enemies.add_child(wolf)
