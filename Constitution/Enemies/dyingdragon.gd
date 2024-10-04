extends StaticBody2D


onready var sprite = $AnimatedSprite

func _ready():
	sprite.frame = 0
	sprite.stop()	

func _on_InteractZone_healdragon():
	sprite.play()

func _on_AnimatedSprite_animation_finished():
	pass # Replace with function body.
