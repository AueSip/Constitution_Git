extends Node2D

onready var musicInstance = $"/root/MusicInstances"

func _ready():
	$YSort/Player.global_position = Global.player_pos
	$DeathScreen/DeadMenu.visible = false
	DayNightCycle.visible = true


func _on_Area2D_body_entered(body):
	musicInstance.get_node("Forest").play()
	musicInstance.get_node("Background Music").play()


func _on_Area2D_body_exited(body):
	musicInstance.get_node("Forest").stop()
	musicInstance.get_node("Background Music").stop()

