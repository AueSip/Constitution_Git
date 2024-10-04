extends Area2D

var boss = preload("res://Enemies/Slimeboss.tscn")

func _ready():
	visible = false
	
func _process(delta):
	boss.connect("dead")
	visible = true
