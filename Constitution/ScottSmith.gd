extends StaticBody2D

onready var animatedSprite = $ScottSmithSprite
onready var sparks = $Sparks
onready var interactZone = $InteractZone


func _ready():
	animatedSprite.play("Smithing")
	sparks.play()



func _on_Interaction_body_entered(body):
	animatedSprite.play("Idle")
	sparks.hide()

func _on_Interaction_body_exited(body):
	animatedSprite.play("Smithing")
	sparks.show()
	sparks.play()
	sparks.frame = 0
