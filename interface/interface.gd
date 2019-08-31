extends Control

signal inhabitants_updated(value)
signal air_updated(value)
signal energy_updated(value)

func _ready():
	var inhabitantsbar = get_node("Bars/InhabitantsBar")
	var airbar = get_node("Bars/AirBar")
	var energybar = get_node("Bars/EnergyBar")
	
	inhabitantsbar.initialize(100)
	airbar.initialize(100)
	energybar.initialize(100)

#func _on_Health_health_changed(inhabitants):
#	emit_signal("inhabitants_updated", inhabitants)
