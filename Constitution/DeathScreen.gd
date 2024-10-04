extends Control
var deadMenu = self
var stats = PlayerStats


func _process(delta):
	if stats.health <= 0:
		visible = true
	
func _on_Quit_pressed():
	get_tree().quit()
