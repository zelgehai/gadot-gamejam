extends CanvasLayer
const MAX_CHARGES = 4
var charges = MAX_CHARGES
var cooldown_timers = ["$cd1", "$cd2", "$cd3", "$cd4"] # Paths to the Timer nodes
var progress_bars = ["$HContainer/bar1", "$HContainer/bar2", "$HContainer/bar3", "$HContainer/bar4"] # Paths to the TextureProgressBar nodes

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(!$cd1.is_stopped()):
		$HContainer/bar1.value = 100*($cd1.time_left/$cd1.wait_time)
	if(!$cd2.is_stopped()):
		$HContainer/bar2.value = 100*($cd2.time_left/$cd2.wait_time)
	if(!$cd3.is_stopped()):
		$HContainer/bar3.value = 100*($cd3.time_left/$cd3.wait_time)
	if(!$cd4.is_stopped()):
		$HContainer/bar4.value = 100*($cd4.time_left/$cd4.wait_time)

func arcaneKeyPressed() -> void:
	if charges > 0:
		charges -= 1
		Globals.spawnArcaneDash()
		
		if $cd1.is_stopped():
			$cd1.start()
		elif $cd2.is_stopped():
			$cd2.start()
		elif $cd3.is_stopped():
			$cd3.start()
		elif $cd4.is_stopped():
			$cd4.start()
	else:
		print("no charges available!")


func _on_cd_1_timeout() -> void:
	charges += 1

func _on_cd_2_timeout() -> void:
	charges += 1

func _on_cd_3_timeout() -> void:
	charges += 1

func _on_cd_4_timeout() -> void:
	charges += 1
