extends Node2D

export (PackedScene) var inside_scene

func _on_Doorway_body_entered(body):
	body.cave = self

func _on_Doorway_body_exited(body):
	if body.cave == self:
		body.cave = null

func enter():
	get_tree().change_scene(inside_scene.resource_path)
	
