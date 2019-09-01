extends Node2D

func _ready():
	$Network.create_server("Player1")
	#$Network.connect_to_server("Player2")