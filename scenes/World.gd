extends Node2D

func _ready():
	$Network.create_server("test1")
	#$Network.connect_to_server("test2")