extends Area2D
var player_node: CharacterBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var point = player_node.get_node("SelfPoint")
	position = point.global_position
	player_node.position = get_global_mouse_position() #moves player to mouse pos
	#Timer to delete instance after animation
	$Timer.start()
	var player_sprite = player_node.get_node("PlayerSprite")
	var animated_player_sprite = player_node.get_node("AnimatedSprite2D")
	player_sprite.visible = false
	animated_player_sprite.visible = true
	animated_player_sprite.play("arcaneDashAppear")
	
func _on_timer_timeout() -> void:
	var player_sprite = player_node.get_node("PlayerSprite")
	var animated_player_sprite = player_node.get_node("AnimatedSprite2D")
	player_sprite.visible = true
	animated_player_sprite.visible = false
	call_deferred("queue_free")
