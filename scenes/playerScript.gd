extends CharacterBody2D
signal enemySpawnerSignal(pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('Player Script Init')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#input
	var direction = Input.get_vector("left","right","up", "down")
	velocity = direction  * 400
	move_and_slide()
	
	if Input.is_action_just_pressed("ePressed"):
		print("sending random spawn Marker")
		#randomly select marker
		var enemySpawnMarkers = $enemySpawnPositions.get_children()
		var selectedEnemyMarker = enemySpawnMarkers[randi() % enemySpawnMarkers.size()] #randomly selects one of the markers
		#emit position we selected.
		enemySpawnerSignal.emit(selectedEnemyMarker.global_position)
