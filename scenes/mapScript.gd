extends Node2D
var spawningActive = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Setting Player Starting Position:")
	$Player.position.x = 500
	$Player.position.y = 500
	$UI.update_health_amount()
	
	#To test the integrity of the drop
	$"Buff Container/Physical".buffType = 1
	$"Buff Container/Elemental".buffType = 2
	$"Buff Container/Arcane".buffType = 3

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
	if(Input.is_action_just_pressed("R_Pressed")):
		Globals.spawnArcaneDash()
	if(Input.is_action_just_pressed("ePressed")): #Press E to activate enemy spawning
		if spawningActive == false:
			print("ACTIVATING ENEMY SPAWNING")
			$mobSpawnTimer.start()	#starts enemy spawning
			spawningActive = true 
		else:
			print("STOPPING ENEMY SPAWNING")
			$mobSpawnTimer.stop()   #stops spawning
			spawningActive = false

#on Timer, Spawns a Random Mob type at a random mobSpawner Location
func _on_mob_spawn_timer_timeout() -> void:
	if Globals.current_enemies_alive < Globals.max_enemies_allowed:
		print("number of alive enemies:", Globals.current_enemies_alive)
		#select random enemySpawner Location
		var enemySpawnMarkers = $enemySpawners.get_children()
		var selectedEnemyMarker = enemySpawnMarkers[randi() % enemySpawnMarkers.size()] #Randomly selects one of the markers
		var mobType = randi() % 100 + 1 #Spawns Random mob type from 1-> 2   #1 is for wolf 2-direWolf 3- Ogre
		#print(mobType) #Debug purposes
		if mobType <= Globals.wolf_Spawn_Rate: 
			var wolf = Globals.wolf_scene.instantiate()
			wolf.position = selectedEnemyMarker.global_position
			wolf.player_node = $Player
			$enemies.add_child(wolf) #spawned wolf
			Globals.current_enemies_alive += 1
		if mobType > Globals.wolf_Spawn_Rate and mobType <= Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate:
			var direWolf = Globals.direWolf_scene.instantiate()
			direWolf.position = selectedEnemyMarker.global_position
			direWolf.player_node = $Player
			$enemies.add_child(direWolf)
			Globals.current_enemies_alive += 1
		if mobType > Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate and mobType <= Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate+Globals.ogre_Spawn_Rate:
			var ogre = Globals.ogre_scene.instantiate()
			ogre.position = selectedEnemyMarker.global_position
			ogre.player_node = $Player
			$enemies.add_child(ogre)
			Globals.current_enemies_alive += 1
		
