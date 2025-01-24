extends CharacterBody2D
var canDamage = true
var canShoot = true
var player_node: CharacterBody2D = null #reference to the player node
var direction_to_player = Vector2(1,0)
var speed = 60 #Min Speed of Small Slime
var randomized_speed = 1
var is_dead = false
var big_slime_node: CharacterBody2D = null

var power = 1
var itemType = 4 #
var dropChance = 5
var health = 1
var mob_experience = 1

func _ready() -> void:
	direction_to_player = (player_node.global_position - global_position).normalized()
	randomized_speed = (randi() % 250 + speed) # Random num from speed -> 500
	
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
		Globals.spawn_item(itemType, dropChance, position)
		$"../../UI".update_expTracker(mob_experience)
		call_deferred("queue_free") #Deletes slime when hit. Used
		
	
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
