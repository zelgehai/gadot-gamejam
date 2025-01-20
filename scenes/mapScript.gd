extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Setting Player Starting Position:")
	$Player.position.x = 500
	$Player.position.y = 500
	$UI.update_health_amount()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("mouseLeftClick") and !Input.is_action_just_pressed("SHFTLeftClick")):
		Globals.spawnMiniBolt()
	if(Input.is_action_just_pressed("mouseRightClick") and !Input.is_action_just_pressed("SHFTRightClick")):
		Globals.spawnSlash()
	if(Input.is_action_just_pressed("SHFTRightClick")):
		Globals.spawnKindleWall()
	if(Input.is_action_just_pressed("SHFTLeftClick")):
		Globals.spawnBlock()
		

func _on_player_enemy_spawner_signal(pos: Variant) -> void:
	print("Spawning Wolf...")
	#creating instance of a wolf
	var wolf = Globals.wolf_scene.instantiate()
	wolf.position = pos
	#Passing player node reference to the wolf script
	wolf.player_node = $Player
	$enemies.add_child(wolf)
