extends Node2D

export var hosting = false

func _ready():
	if hosting:
		$Network.create_server("Player1")
	else:
		$Network.connect_to_server("Player2")