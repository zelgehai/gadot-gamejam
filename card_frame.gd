extends CanvasLayer

var cardSwitches = [true, false, false, true]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for index in range(cardSwitches.size()):
		var value = cardSwitches[index]
		print("Count:", index, "Value:", value)
	updateCardSlots()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#Sets the visiblity of the cards to off when false
func updateCardSlots() -> void:
	$CardImageList/Card1.visible = cardSwitches[0]
	$CardImageList/Card2.visible  = cardSwitches[1]
	$CardImageList/Card3.visible  = cardSwitches[2]
	$CardImageList/Card4.visible  = cardSwitches[3]
