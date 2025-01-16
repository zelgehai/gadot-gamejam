extends Node2D

var wolf_scene: PackedScene = preload("res://scenes/wolf.tscn") #Make sure ending is .tscn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Setting Player Starting Position:")
	$Player.position.x = 500
	$Player.position.y = 250
	#create instance of a wolf
	var wolf = wolf_scene.instantiate() 
	add_child(wolf)
	wolf.position.x = 300
	wolf.position.y = 150

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#Out of Bounds, MAP Limits:
	if $Player.position.x > 1150:
		print("position exceeded!")
		$Player.position.x = 0
	if $Player.position.x < 0:
		print("Neg Limit Exceeded")
		$Player.position.x = 1150
	if $Player.position.y < 0:
		$Player.position.y = 650
	if $Player.position.y > 650:
		$Player.position.y = 0
