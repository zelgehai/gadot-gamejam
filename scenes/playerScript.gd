extends CharacterBody2D
signal enemySpawnerSignal(pos)
var player_direction = Vector2(1,0)
# Called when the node enters the scene tree for the first time.
#Health Value at Start:

func _ready() -> void:
	print('player spawned')
	player_direction = (get_global_mouse_position() - position).normalized()
	# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	player_direction = (get_global_mouse_position() - position).normalized()
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

func player_hit():
	print("Player was HIT, Health = ", Globals.health_amount)
	$"../UI".update_health_amount()
	
func giveDirection() -> Vector2:
	return player_direction

#Call this function to remove player sprite
func remove_player_sprite():
	print("sprite Func works")
	var player_sprite = $PlayerSprite
	player_sprite.texture = null
	
