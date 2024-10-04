extends Control

func _on_Sounds_value_changed(value: float) -> void:
	set_bus_volume(2, value)
	$ColorRect/Label2.text = "%d%%" % (value * 100)

func _on_Music_value_changed(value: float) -> void:
	set_bus_volume(1, value)
	$ColorRect/Label.text = "%d%%" % (value * 100)

func _on_Ambient_value_changed(value: float) -> void:
	set_bus_volume(3, value)
	$ColorRect/Label3.text = "%d%%" % (value * 100)
	
func set_bus_volume(bus_index: int, value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear2db(value))
	AudioServer.set_bus_mute(bus_index, value < 0.01)


func _on_Button_pressed():
	self.visible = false
