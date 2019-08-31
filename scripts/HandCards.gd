extends Node2D

var cards = []

export var maxHandSize = 5
export var padding = Vector2(5, 10)

onready var slots = get_parent().get_node("Slots")

func _ready():
	while(cards.size() < maxHandSize):
		cards.append(get_parent().get_node("CardStack").drawCard())
	print(cards)
	for i in range(0, cards.size()):
		cards[i].position = Vector2(padding.x + (cards[i].get_texture().get_size().x + padding.x) * i, get_viewport().get_texture().get_size().y - cards[i].get_texture().get_size().y / 2 - padding.y)
		add_child(cards[i])
	
