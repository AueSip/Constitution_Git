extends Node

export(int) var max_health = 1 setget set_max_health
var health = max_health setget  set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)


func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)
	
	
func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
func _ready():
	self.health = max_health
	self.item1 = 0

	
export(int) var max_item1 = 1 setget set_max_item1
var item1 = max_item1 setget  set_item1

signal no_item1
signal item1_changed(value)
signal max_item1_changed(value)

func set_max_item1(value):
	max_item1 = 1
	self.item1 = min(item1, max_item1)
	emit_signal("max_item1_changed", max_item1)
	
	
func set_item1(value):
	item1 = value
	emit_signal("item1_changed", item1)
	if item1 == 1:
		emit_signal("has_item1")
