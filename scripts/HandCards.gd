extends Node2D

var cards = []

export var maxHandSize = 5
export var padding = Vector2(5, 10)
export var imageSize = Vector2(64, 128)

var selectedCard

onready var slots = get_parent().get_node("Slots")

func _ready():
	while(cards.size() < maxHandSize):
		cards.append(get_parent().get_node("CardStack").drawCard())
	print(cards)
	for i in range(0, cards.size()):
		cards[i].position = Vector2(padding.x + (imageSize.x + padding.x) * i, get_viewport().get_texture().get_size().y - imageSize.y / 2 - padding.y)
		add_child(cards[i])
	

func positionToCard(pos):
	var cardX = (pos.x - padding.x) / (imageSize.x + padding.x)
	print(cardX)
	if cardX < 0 or cardX > cards.size():
		return null
	else:
		return cards[cardX]

func _process(delta):
	if Input.is_action_just_pressed("game_click"):
		if !selectedCard:
			selectedCard = positionToCard(get_global_mouse_position())
			return
		
		if selectedCard:
			selectedCard = null