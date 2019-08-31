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
		cards[i].connect("card_clicked", self, "_on_card_clicked")
		add_child(cards[i])


func _on_card_clicked(card):
	print("Clicked card:")
	print(card)
	selectedCard = card

func _on_slot_released(slot):
	print("Released on slot:")
	print(slot)
	if slot.canPlace(selectedCard, "A"):
		selectedCard.move(slot.position)
		slot.place(selectedCard, "A")
		selectedCard = null