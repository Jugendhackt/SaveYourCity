extends Node

#const DEFAULT_IP = '172.16.108.5'

export var DEFAULT_PORT = 80
export var DEFAULT_IP = '127.0.0.1'

signal player_disconnected
signal server_disconnected

func _ready():
	get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
	get_tree().connect('network_peer_connected', self, '_on_player_connected')

func create_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, 2)
	get_tree().set_network_peer(peer)

func connect_to_server():
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)


func _connected_to_server():
	print("Connected to Server!")

func _on_player_disconnected(id):
	print("Player disconnected")

func _on_player_connected(connected_player_id):
	print("Player connected")