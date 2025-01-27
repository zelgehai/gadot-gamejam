extends CharacterBody2D
var canDamage = true
var canShoot = true
var player_node: CharacterBody2D = null #reference to the player node
var direction_to_player = Vector2(1,0)
var speed = 50 #Min Speed of GSlime
var randomized_speed = 1
var is_dead = false

var power = 1
var itemType = 4 #
var dropChance = 1
var health = 4
var mob_experience = 1

func _ready() -> void:
	direction_to_player = (player_node.global_position - global_position).normalized()
	randomized_speed = (randi() % 150 + speed) # Random num from speed -> 500
	
func _process(_delta: float) -> void:
	#if player_node:
		#get directions towards the player [ to know to face it]
		direction_to_player = (player_node.global_position - global_position).normalized()
		#Calculate Distance to player
		var distance_to_player = global_position.distance_to(player_node.global_position)
		velocity = direction_to_player * randomized_speed #moves toward player
		move_and_slide()
		#always look at player
		look_at(player_node.global_position)
		rotation += deg_to_rad(90)
		
#calls this func if slime got hit
func hit(dmg):
	if is_dead:
		return
		
	health -= dmg
	if(health <= 0):
		is_dead = true
		
		var spawnSmallSlime = Globals.smallSlime_scene.instantiate() as CharacterBody2D
		spawnSmallSlime.player_node = $"../../../map/Player"
		spawnSmallSlime.big_slime_node = $"." #Passes self node
		spawnSmallSlime.position = $smalSlimeSpawnLocation.global_position
		$"../../../map/EnemyProjectiles".call_deferred("add_child",spawnSmallSlime) #Fix for a call_deffered error
		#Spawning Slime #2
		var spawnSmallSlime2 = Globals.smallSlime_scene.instantiate() as CharacterBody2D
		spawnSmallSlime2.player_node = $"../../../map/Player"
		spawnSmallSlime2.big_slime_node = $"." #Passes self node
		spawnSmallSlime2.position = $smalSlimeSpawnLocation2.global_position
		$"../../../map/EnemyProjectiles".call_deferred("add_child",spawnSmallSlime2) #Fix for a call_deffered error
		#Spawning Slime #3
		var spawnSmallSlime3 = Globals.smallSlime_scene.instantiate() as CharacterBody2D
		spawnSmallSlime3.player_node = $"../../../map/Player"
		spawnSmallSlime3.big_slime_node = $"." #Passes self node
		spawnSmallSlime3.position = $smalSlimeSpawnLocation3.global_position
		$"../../../map/EnemyProjectiles".call_deferred("add_child",spawnSmallSlime3) #Fix for a call_deffered error
		
		Globals.spawn_item(itemType, dropChance, position)
		$"../../UI".update_expTracker(mob_experience)
		call_deferred("queue_free") #Deletes Big when hit. Used
		
	
func _on_area_2d_body_entered(body) -> void:
	if canDamage and !Globals.Invulnerable:
		if body.name == "Player":
			Globals.damage_Player(power)
			body.player_hit()
		canDamage = false
		$Timer.start()

func _on_timer_timeout() -> void:
	canDamage = true

#Rate at which Wisp can Shoot
func _on_shoot_spell_cooldown_timeout() -> void:
	canShoot = true
