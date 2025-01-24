extends Node2D
var spawningActive = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Setting Player Starting Position:")
	$Player.position.x = 1000
	$Player.position.y = 700
	$UI.update_health_amount()
	
	#To test the integrity of the drop
	$"Buff Container/Physical".buffType = 1
	$"Buff Container/Elemental".buffType = 2
	$"Buff Container/Arcane".buffType = 3
	$"Buff Container/Speed".buffType = 4
	$"Buff Container/Health".buffType = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("mouseLeftClick") and !Input.is_action_just_pressed("SHFTLeftClick")):
		#Globals.spawnMiniBolt()
		$UI/CardFrame.playCard(0)
	if(Input.is_action_just_pressed("mouseRightClick") and !Input.is_action_just_pressed("SHFTRightClick")):
		$UI/CardFrame.playCard(1)
	if(Input.is_action_just_pressed("SHFTRightClick")):
		$UI/CardFrame.playCard(3)
	if(Input.is_action_just_pressed("SHFTLeftClick")):
		$UI/CardFrame.playCard(2)
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
	Globals.current_enemies_alive = $enemies.get_child_count()
	print("# of enemies alive:", Globals.current_enemies_alive)
	if Globals.current_enemies_alive < Globals.max_enemies_allowed:
		#select random enemySpawner Location
		var enemySpawnMarkers = $enemySpawners.get_children()
		var selectedEnemyMarker = enemySpawnMarkers[randi() % enemySpawnMarkers.size()] #Randomly selects one of the markers
		var mobType = randi() % 100 + 1 #Spawns Random mob type 1-100 value based on GLobal #
		#print(mobType) #Debug purposes
		if mobType <= Globals.wolf_Spawn_Rate: 
			var wolf = Globals.wolf_scene.instantiate()
			wolf.position = selectedEnemyMarker.global_position
			wolf.player_node = $Player
			$enemies.add_child(wolf) #spawned wolf
		if mobType > Globals.wolf_Spawn_Rate and mobType <= Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate:
			var direWolf = Globals.direWolf_scene.instantiate()
			direWolf.position = selectedEnemyMarker.global_position
			direWolf.player_node = $Player
			$enemies.add_child(direWolf)
		if mobType > Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate and mobType <= Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate+Globals.ogre_Spawn_Rate:
			var ogre = Globals.ogre_scene.instantiate()
			ogre.position = selectedEnemyMarker.global_position
			ogre.player_node = $Player
			$enemies.add_child(ogre)
		if mobType > Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate+Globals.ogre_Spawn_Rate and mobType <= Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate+Globals.ogre_Spawn_Rate+Globals.wisp_Spawn_Rate:
			var wisp = Globals.wisp_scene.instantiate()
			wisp.position = selectedEnemyMarker.global_position
			wisp.player_node = $Player
			$enemies.add_child(wisp)
		if mobType > Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate+Globals.ogre_Spawn_Rate+Globals.wisp_Spawn_Rate and mobType <= Globals.wolf_Spawn_Rate+Globals.dire_Spawn_Rate+Globals.ogre_Spawn_Rate+Globals.wisp_Spawn_Rate+Globals.greater_wisp_Spawn_Rate:
			var gwisp = Globals.greater_wisp_scene.instantiate()
			gwisp.position = selectedEnemyMarker.global_position
			gwisp.player_node = $Player
			$enemies.add_child(gwisp)


func _on_time_when_spawn_rate_increases_timeout() -> void:
	var max_spawnrate = 0.11
	if $mobSpawnTimer.wait_time <= max_spawnrate:
		return
	else:
		$mobSpawnTimer.wait_time *= 0.89 #Increase Spawn rate by 11% Every Timeout [20 seconds]
		print("increassing spawn rate to:", $mobSpawnTimer.wait_time)
