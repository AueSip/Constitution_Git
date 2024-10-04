extends Control

var stats = PlayerStats

onready var item1Image = $Item1/Item1Full

func _process(delta):
	if stats.item1 == 1:
		item1Image.visible = true
	else:
		item1Image.visible = false
