extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.position.x = 500
	$Player.position.y = 250

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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

	if Input.is_action_pressed("left"):
		$Player.position.x -= 1
	if Input.is_action_pressed("right"):
		$Player.position.x += 1
	if Input.is_action_pressed("down"):
		$Player.position.y += 1
	if Input.is_action_pressed("up"):
		$Player.position.y -= 1
