extends Node2D
var spawningActive = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Setting Player Starting Position:")
	$Player.position.x = 1000
	$Player.position.y = 700
	$UI.update_health_amount()
	#SetStarting Attack speed
	$miniBoltTimer.wait_time = Globals.attackSpeed
	#To test the integrity of the drop
	$"Buff Container/Physical".buffType = 1
	$"Buff Container/Elemental".buffType = 2
	$"Buff Container/Arcane".buffType = 3
	$"Buff Container/Speed".buffType = 4
	$"Buff Container/Health".buffType = 5
	$"Buff Container/Card".buffType = 6
	#test
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("mouseLeftClick") and !Input.is_action_just_pressed("SHFTLeftClick")):
		$UI/CardFrame.playCard(0)
	if(Input.is_action_just_pressed("mouseRightClick") and !Input.is_action_just_pressed("SHFTRightClick")):
		$UI/CardFrame.playCard(1)
	if(Input.is_action_just_pressed("SHFTRightClick")):
		$UI/CardFrame.playCard(3)
	if(Input.is_action_just_pressed("SHFTLeftClick")):
		$UI/CardFrame.playCard(2)
	if(Input.is_action_just_pressed("Tab")):
		print("TAB")
		get_tree().paused = true
		$AddPoints.visible = true
	if(Input.is_action_just_pressed("R_Pressed")):
		$UI/arcaneDashChargesLayer.arcaneKeyPressed()
		#Globals.spawnArcaneDash()
	if(Input.is_action_just_pressed("ePressed")): #Press E to activate enemy spawning
		if spawningActive == false:
			print("ACTIVATING ENEMY SPAWNING")
			$mobSpawnTimer.start()	#starts enemy spawning
			spawningActive = true 
		else:
			print("STOPPING ENEMY SPAWNING")
			$mobSpawnTimer.stop()   #stops spawning
			spawningActive = false

func _on_mob_generated(mob_number):
	print("Received Mob number:", mob_number)
	
#on Timer, Spawns a Random Mob type at a random mobSpawner Location
func _on_mob_spawn_timer_timeout() -> void:
	Globals.current_enemies_alive = $enemies.get_child_count()
	print("# of enemies alive:", Globals.current_enemies_alive)
	if Globals.current_enemies_alive < Globals.max_enemies_allowed:
		##select random enemySpawner Location
		var enemySpawnMarkers = $enemySpawners.get_children()
		var selectedEnemyMarker = enemySpawnMarkers[randi() % enemySpawnMarkers.size()] #Randomly selects one of the markers
		
		#New Code---------------------------
		var mob_data = $SpawnerAlgorithm.get_random_mob() #returns dictionary of the mob
		if mob_data:
			var mob_instance = mob_data.scene.instantiate() #uses mob's scene to instantiate
			mob_instance.position = selectedEnemyMarker.global_position
			mob_instance.player_node = $Player
			#mob counter, for renaming purposes in the tree remote "enemies"
			#renames the mob, then puts lists it under "enemies" in the map scene
			if mob_data.name in $SpawnerAlgorithm.mob_count:
				$SpawnerAlgorithm.mob_count[mob_data.name] += 1
			else:
				$SpawnerAlgorithm.mob_count[mob_data.name] = 1
			#renames mob:
			mob_instance.name = mob_data.name + str($SpawnerAlgorithm.mob_count[mob_data.name])
			#Added Mob to the scene
			$enemies.add_child(mob_instance)


#code that increases the spawn rate by a % every x seconds
func _on_time_when_spawn_rate_increases_timeout() -> void:
	var max_spawnrate = 0.11
	if $mobSpawnTimer.wait_time <= max_spawnrate:
		return
	else:
		$mobSpawnTimer.wait_time *= 0.89 #Increase Spawn rate by 11% Every Timeout [20 seconds]
		print("increassing spawn rate to:", $mobSpawnTimer.wait_time)


func _on_mini_bolt_timer_timeout() -> void:
	Globals.spawnMiniBolt()
