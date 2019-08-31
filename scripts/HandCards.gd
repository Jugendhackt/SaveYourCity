extends Node2D

var cards = []
var selectedCard

export var maxHandSize = 5
export var padding = Vector2(5, 10)
export var imageSize = Vector2(64, 128)

onready var canPlay = true

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
	if canPlay:
		selectedCard = card

func _on_slot_released(slot):
	if selectedCard and slot.canPlace(selectedCard, "A"):
		playerTurn(slot)

func playerTurn(slot):
	playCard(slot, selectedCard, "A")
	#TODO: send enemyTurn(slot, selectedCard)
	selectedCard = null

func playCard(slot, card, player):
	card.move(slot.position)
	slot.place(card, player)

func endTurn():
	canPlay = false

func enemyTurn(slot, card):
	selectedCard = card
	playCard(slot, card, "B")
	canPlay = true