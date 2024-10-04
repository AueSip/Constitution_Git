extends Node2D

onready var playerDetectionZone = $PlayerDetectionZone

signal item1_collected

func _on_PlayerDetectionZone_body_entered(body):
	PlayerStats.item1 = 1
	queue_free()
