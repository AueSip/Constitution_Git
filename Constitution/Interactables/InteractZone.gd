extends Area2D

var stats = PlayerStats
signal healdragon
func _on_InteractZone_body_entered(body):
	body.interact = self


func _on_InteractZone_body_exited(body):
	if body.interact == self:
		body.interact = null

func item1deposited():
	stats.item1 -=1
	print ("item Deposited")
	emit_signal("healdragon")
