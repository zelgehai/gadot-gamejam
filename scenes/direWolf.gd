extends CharacterBody2D
var canDamage = true
var player_node: CharacterBody2D = null #reference to the player node
var direction_to_player = Vector2(1,0)
var speed = 100 #Max Speed of Wolf
var randomized_speed = 1
var is_dead = false

var power = 1
var itemType = 2#
var dropChance = 100
var health = 5
var mob_experience = 1

func _ready() -> void:
	direction_to_player = (player_node.global_position - global_position).normalized()
	randomized_speed = (randi() % 250 + speed) # Random num from speed -> 500
	
func _process(_delta: float) -> void:
	#if player_node:
		#get directions towards the player [ to know to face it]
		direction_to_player = (player_node.global_position - global_position).normalized()
		velocity = direction_to_player * randomized_speed #moves toward player
		move_and_slide()
		look_at(player_node.global_position)
		rotation += deg_to_rad(90)
		
#calls this func if direwolf got hit
func hit(dmg):
	if is_dead:
		return
		
	health -= dmg
	if(health <= 0):
		is_dead = true
		call_deferred("queue_free") #Deletes Direwolf when hit. Used
		Globals.spawn_item(itemType, dropChance, position)
		$"../../UI".update_expTracker(mob_experience)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if canDamage and !Globals.Invulnerable:
		if body.name == "Player":
			Globals.damage_Player(power)
			body.player_hit()
		canDamage = false
		$Timer.start()

func _on_timer_timeout() -> void:
	canDamage = true
