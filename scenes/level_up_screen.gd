extends CanvasLayer

var cardList: Array = [1,1,1]

#Reference from CardList Map, min is the lowest number you wish to pull from
#max is the highest number you want to pull from 
#Ex: 4min -> 10 max means cards 4-10 can potentially be selected
var minRandomRange = 2
var maxRandomRange = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cardList[0] = randi() % maxRandomRange + minRandomRange
	cardList[1] = randi() % maxRandomRange + minRandomRange
	cardList[2] = randi() % maxRandomRange + minRandomRange
	
	$Label/card1.animation = str(cardList[0])
	$Label/card2.animation = str(cardList[1])
	$Label/card3.animation = str(cardList[2])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_slot_1_pressed() -> void:
	Globals.DECK_LIST.append(cardList[0])
	get_tree().paused = false
	$".".visible = false
	
func _on_button_slot_2_pressed() -> void:
	Globals.DECK_LIST.append(cardList[1])
	get_tree().paused = false
	$".".visible = false

func _on_button_slot_3_pressed() -> void:
	Globals.DECK_LIST.append(cardList[2])
	get_tree().paused = false
	$".".visible = false

func randomizeValues() -> void:
	cardList[0] = randi() % maxRandomRange + minRandomRange
	cardList[1] = randi() % maxRandomRange + minRandomRange
	cardList[2] = randi() % maxRandomRange + minRandomRange
	
	$Label/card1.animation = str(cardList[0])
	$Label/card2.animation = str(cardList[1])
	$Label/card3.animation = str(cardList[2])
