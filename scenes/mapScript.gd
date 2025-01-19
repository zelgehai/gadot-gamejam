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
		spawnMiniBolt()
	if(Input.is_action_just_pressed("mouseRightClick") and !Input.is_action_just_pressed("SHFTRightClick")):
		spawnSlash()
	if(Input.is_action_just_pressed("SHFTRightClick")):
		spawnKindleWall()
	if(Input.is_action_just_pressed("SHFTLeftClick")):
		spawnBlock()
		
func spawnMiniBolt() -> void:
	var MB = Globals.MiniBolt.instantiate() as Area2D
	MB.player_node = $Player
	$Projectiles.add_child(MB)

func spawnSlash() -> void:
	var SL = Globals.Slash.instantiate() as Area2D
	SL.player_node = $Player
	$Projectiles.add_child(SL)

func spawnBlock() -> void:
	var BK = Globals.Block.instantiate() as Area2D
	BK.player_node = $Player
	$Projectiles.add_child(BK)

func spawnKindleWall() -> void:
	var KW = Globals.KindleWall.instantiate() as Area2D
	KW.player_node = $Player
	$Projectiles.add_child(KW)

func _on_player_enemy_spawner_signal(pos: Variant) -> void:
	print("Spawning Wolf...")
	#creating instance of a wolf
	var wolf = Globals.wolf_scene.instantiate()
	wolf.position = pos
	#Passing player node reference to the wolf script
	wolf.player_node = $Player
	$enemies.add_child(wolf)
