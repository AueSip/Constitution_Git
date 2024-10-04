extends CanvasModulate



func _ready():
	visible = false
	$AnimationPlayer.play("Day_Night_Cycle")
	$AnimationPlayer.seek(150, true)
