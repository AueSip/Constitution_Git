extends Node

export(int) var max_item1 = 1 setget set_max_item1
var item1 = max_item1 setget  set_item1

signal no_item1
signal item1_changed(value)
signal max_item1_changed(value)

func set_max_item1(value):
	max_item1 = value
	self.item1 = min(item1, max_item1)
	emit_signal("max_item1_changed", max_item1)
	
	
func set_item1(value):
	item1 = value
	emit_signal("item1_changed", item1)
	if item1 <= 0:
		emit_signal("no_item1")

func _ready():
	self.item1 = max_item1
