extends Node2D

const HpPickupSound = preload("res://Music and Sounds/HpPickupSound.tscn")

onready var playerDetectionZone = $PlayerDetectionZone

func _on_PlayerDetectionZone_body_entered(body):
	if body != null && PlayerStats.health !=5 :
		var pickupsound = HpPickupSound.instance()
		get_tree().current_scene.add_child(pickupsound)
		PlayerStats.health +=1
		queue_free()

