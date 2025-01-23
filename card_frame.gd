extends CanvasLayer

#Represents whether the slot has something inside, true = something is inside, false nothing inside
#WARNING always start with all 4 values as FALSE
var cardSwitches: Array = [false, false, false, false]
#The cards currently loaded into the slots, named "hand" for display purposes
var hand: Array = [null,null,null,null]

#Card being pushed
var card = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Globals.DECK_LIST.append(2)
	Globals.DECK_LIST.append(3)
	Globals.DECK_LIST.append(4)
	Globals.DECK_LIST.append(1)
	Globals.DECK_LIST.append(3)
	#Zel's First Deck
	#Globals.DECK_LIST.append(1)
	#Globals.DECK_LIST.append(1)
	#Globals.DECK_LIST.append(1)
	#Globals.DECK_LIST.append(2)
	#Globals.DECK_LIST.append(2)
	#Globals.DECK_LIST.append(2)
	#Globals.DECK_LIST.append(2)
	#Globals.DECK_LIST.append(4)
	#Globals.DECK_LIST.append(4)
	#Globals.DECK_LIST.append(4)
	
	#Ramon's First Deck
	#Globals.DECK_LIST.append(4)
	#Globals.DECK_LIST.append(4)
	#Globals.DECK_LIST.append(3)
	#Globals.DECK_LIST.append(3)
	#Globals.DECK_LIST.append(1)
	#Globals.DECK_LIST.append(1)
	
	#Globals.DECK_LIST.append(1)
	#Globals.DECK_LIST.append(2)
	#Globals.DECK_LIST.append(2)
	#Globals.DECK_LIST.append(2)
	
	
	updateCardSlots()
	for index: bool in cardSwitches:
		print(index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(!$cooldown1.is_stopped()):
		$cooldownOverLay1.visible = true
	else:
		$cooldownOverLay1.visible = false
		
	if(!$cooldown2.is_stopped()):
		$cooldownOverLay2.visible = true
	else:
		$cooldownOverLay2.visible = false
	
	if(!$cooldown3.is_stopped()):
		$cooldownOverLay3.visible = true
	else:
		$cooldownOverLay3.visible = false
	
	if(!$cooldown4.is_stopped()):
		$cooldownOverLay4.visible = true
	else:
		$cooldownOverLay4.visible = false
		
		
	updateCardSlots()
	print("Deck Size: ", Globals.DECK_LIST.size())
	print("Deck: ")
	print(Globals.DECK_LIST)
	print("Hand: ")
	print(hand)
	print("Discard: ")
	print(Globals.DISCARD_LIST)

	if(slotEmpty()):
		print("There is an Empty Slot in position: ", getEmptySlot())
		if(deckEmpty()):
			print("Deck is Empty, Cannot draw")
			if(discardEmpty()):
				print("Discard is Empty")
				pass
			else:
				print("Discard has elements, can shuffle")
				shuffleDeck()	
				drawCard(getEmptySlot())
		else:
			print("Deck has elements, draw")				
			drawCard(getEmptySlot())
	else:
		print("There is not an empty Slot ")
		print("switches: ", cardSwitches[0],cardSwitches[1],cardSwitches[2],cardSwitches[3] )
	#1. Are any card slots empty?
	#2. Can I draw a card from the deck?
	#3. Do I shuffle my discard into my deck?
	#print(Globals.DECK_LIST.size())

#Sets the visiblity of the cards to off when false
func updateCardSlots() -> void:
	$CardImageList/Card1.visible = cardSwitches[0]
	$CardImageList/Card2.visible  = cardSwitches[1]
	$CardImageList/Card3.visible  = cardSwitches[2]
	$CardImageList/Card4.visible  = cardSwitches[3]

func slotEmpty() -> bool:
	print("Running slotEmpty(): ")
	for i: bool in cardSwitches:
		print("Iterating on [i] = ", i)
		if(i == false):
			print("Breaking statement because an Empty slot was found!")
			return true
	print("Breaking statement because ZERO empty slots found...")
	return false
		
func getEmptySlot() -> int:
	print("Running getEmptySlot(): ")
	var counter: int = 0
	print("counter START: ", counter)
	for i: bool in cardSwitches:
		if(i == false):
			print("breaking statement because a slot was EMPTY in location: ", counter)
			return counter
		counter += 1
	print("breaking statement because ZERO open slots found...")
	return false

func drawCard(slot: int):
	print("Running drawCard(int): ")
	print("Globals.DECK_LIST BEFORE pop: ", Globals.DECK_LIST)
	var targetCard = Globals.DECK_LIST.pop_front()
	changeSprite(slot, targetCard)
	print("targetCard: ", targetCard)
	print("Globals.DECK_LIST AFTER pop: ", Globals.DECK_LIST)
	print("hand[slot] BEFORE reassignment: ", hand[slot])
	hand[slot] = targetCard
	print("hand[slot] AFTER reassignment: ", hand[slot])
	print("cardSwitches[slot] BEFORE reassignment: ", cardSwitches[slot])
	cardSwitches[slot] = true
	print("cardSwitches[slot] AFTER reassignment: ", cardSwitches[slot])

#Discards a card from the slot position. 0 means 'hand' will switch to false, and move that int to discard
func discardCard(slot: int):
	print("discardCard(slot: int): ")
	print("Globals.DISCARD_LIST BEFORE adding: ", Globals.DISCARD_LIST)
	Globals.DISCARD_LIST.append(hand[slot])
	print("Globals.DISCARD_LIST AFTER adding: ", Globals.DISCARD_LIST)
	print("hand[slot] BEFORE removing: ", hand[slot])
	hand[slot] = null
	print("hand[slot] AFTER removing: ", hand[slot])
	print("cardSwitches[slot] BEFORE removing: ", cardSwitches[slot])
	cardSwitches[slot] = false
	print("cardSwitches[slot] AFTER removing: ", cardSwitches[slot])
	
func deckEmpty() -> bool:
	print("Running deckEmpty(): ")
	if Globals.DECK_LIST.size() > 0:
		print("Breaking statement because deck had an element in it!")
		return false
	else:
		print("Breaking statement because ZERO elements found...")
		return true
		
func discardEmpty() -> bool:
	print("Running discardEmpty(): ")
	if Globals.DISCARD_LIST.size() > 0:
		print("Breaking statement because DISCARD had an element in it!")
		return false
	else:
		print("Breaking statement because ZERO elements found...")
		return true
	
func shuffleDeck() -> void:
	print("Running shuffleDeck(): ")
	Globals.DECK_LIST = Globals.DISCARD_LIST.duplicate()
	print("Deck_List updated to: ", Globals.DECK_LIST )
	print("Current Discard_List: ", Globals.DISCARD_LIST)
	Globals.DISCARD_LIST.clear()
	Globals.DECK_LIST.shuffle()
	print("Cleared Discard_List: ", Globals.DISCARD_LIST)
	print("Updated Deck_List: ", Globals.DECK_LIST )
	print("DECK SHUFFLED")

func _on_cooldown_1_timeout() -> void:
	print("TIMER CD1 DONE!!") # Replace with function body.

func _on_cooldown_2_timeout() -> void:
	print("TIMER CD2 DONE!!")# Replace with function body.

func _on_cooldown_3_timeout() -> void:
	print("TIMER CD3 DONE!!") # Replace with function body.

func _on_cooldown_4_timeout() -> void:
	print("TIMER CD4 DONE!!") # Replace with function body.

func playCard(slot: int) -> void:
#When card is played, 0 = LeftCLCK 1= RightCLK 2 = SHFTLEFT 3 = SHIFTRIGHT
	if(slot == 0 and hand[0] and $cooldown1.is_stopped()):
		$cooldown1.wait_time = matchCard(hand[slot])
		discardCard(slot)
		$cooldown1.start()
	if(slot == 1 and hand[1] and $cooldown2.is_stopped()):
		$cooldown2.wait_time = matchCard(hand[slot])
		discardCard(slot)
		$cooldown2.start()
	if(slot == 2 and hand[2] and $cooldown3.is_stopped()):
		$cooldown3.wait_time = matchCard(hand[slot])
		discardCard(slot)
		$cooldown3.start()
	if(slot == 3 and hand[3] and $cooldown4.is_stopped()):
		$cooldown4.wait_time = matchCard(hand[slot])
		discardCard(slot)
		$cooldown4.start()

#This is the offical map of all the cards. Each number represents the card value.
#corresponding values are mapped, just pass it through with that specific value
# 1 Mini Bolt
# 2 Slash
# 3 Block 
# 4 KindleWall
func matchCard(numberInList: int) -> int:
	match numberInList:
		1:
			Globals.spawnMiniBolt()
			var childCount = $"../../Projectiles".get_child_count()
			var newTimer = $"../../Projectiles".get_child(childCount-1).getCooldown()
			return newTimer
		2:
			Globals.spawnSlash()
			var childCount = $"../../Projectiles".get_child_count()
			var newTimer = $"../../Projectiles".get_child(childCount-1).getCooldown()
			return newTimer
		3:
			Globals.spawnBlock()
			var childCount = $"../../Projectiles".get_child_count()
			var newTimer = $"../../Projectiles".get_child(childCount-1).getCooldown()
			return newTimer
		4:
			Globals.spawnKindleWall()
			var childCount = $"../../Projectiles".get_child_count()
			var newTimer = $"../../Projectiles".get_child(childCount-1).getCooldown()
			return newTimer
	return 0

func changeSprite(slot: int, animationName: int) -> int:
	if(slot == 0):
		print("ANIMATION NAME:" , str(animationName))
		$CardImageList/Card1.animation = str(animationName)
	if(slot == 1):
		print("ANIMATION NAME:" , str(animationName))
		$CardImageList/Card2.animation = str(animationName)
	if(slot == 2):
		print("ANIMATION NAME:" , str(animationName))
		$CardImageList/Card3.animation = str(animationName)
	if(slot == 3):
		print("ANIMATION NAME:" , str(animationName))
		$CardImageList/Card4.animation = str(animationName)
	return 0
