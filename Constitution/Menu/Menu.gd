extends Control

onready var menuScene = $Menu
export var mainGameScene : PackedScene

func _ready():
	get_tree().change_scene_to(menuScene)
	
func _on_StartButton_pressed():
	visible = false
	get_tree().change_scene("res://World.tscn")
	
func _on_OptionsButton_pressed():
	Options.get_node("Options1").visible = true


func _on_QuitButton_pressed():
	get_tree().quit()
