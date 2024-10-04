extends Node2D

var entered = false
onready var musicInstance = $"/root/MusicInstances"
var outside = "res://World.tscn"
onready var bossCam = $BossCameraLimiter/BossCamera
onready var camera = $Camera2DCave
onready var boss = $YSort/Enemy
onready var rock = $Rock

func _ready():
	$DeathScreen/DeadMenu.visible = false
	DayNightCycle.visible = false
func _on_Exit_body_entered(body):
	if entered:
		get_tree().change_scene(outside)
		
func _on_Exit_body_exited(body):
	entered = true



func _on_Area2D_body_entered(body):
	musicInstance.get_node("Cave Music").play()

func _on_Area2D_body_exited(body):
	musicInstance.get_node("Cave Music").stop()

func _on_BossCameraLimiter_body_entered(body):
	camera.current = false
	bossCam.current = true
	
func _on_BossCameraLimiter_body_exited(body):
	bossCam.current = false
	camera.current = true

