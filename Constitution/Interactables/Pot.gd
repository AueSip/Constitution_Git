extends Node2D

const PotSound = preload("res://Music and Sounds/PotBreakSound.tscn")
const PotEffect = preload("res://Effects/PotEffect.tscn")
const HeartSpawn = preload("res://Interactables/Heart.tscn")


func create_pot_sound():
	var potSound = PotSound.instance()
	get_parent().add_child(potSound)
	potSound.global_position = global_position

func create_pot_effect():
	var potEffect = PotEffect.instance()
	get_parent().add_child(potEffect)
	potEffect.global_position = global_position
	
func create_heart_pickup():
	var heartSpawn = HeartSpawn.instance()
	get_parent().add_child(heartSpawn)
	heartSpawn.global_position = global_position
	
func _on_Hurtbox_area_entered(area):
	create_pot_effect()
	create_heart_pickup()
	create_pot_sound()
	
func _on_Hurtbox_area_exited(area):
	queue_free()
