extends Node2D

var cards = []
var selectedCard

export var maxHandSize = 5
export var padding = Vector2(5, 10)
export var imageSize = Vector2(64, 128)

onready var canPlay = get_parent().hosting

onready var slots = get_parent().get_node("Slots")

func _ready():
	while(cards.size() < maxHandSize):
		drawCard()
	reorganize()

func drawCard():
	cards.append(get_parent().get_node("CardStack").drawCard())

func reorganize():
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
	cards.remove(cards.find(selectedCard))
	playCard(slot, selectedCard, "A", true)
	
	rpc("send_turn", get_parent().get_node("Slots").slots.find(slot), selectedCard.cardName)
	
	selectedCard = null
	endTurn()

remote func send_turn(slot, card):
	print("Sent turn:")
	print(slot)
	print(card)
	var cardObj = get_parent().get_node("CardStack").createCard("res://cards/" + card + ".tscn")
	var slotObj = get_parent().get_node("Slots").slots[get_parent().get_node("Slots").slots.size() - slot - 1]
	enemyTurn(slotObj, cardObj)

func playCard(slot, card, player, moveTween):
	if moveTween:
		card.move(slot.position)
	else:
		card.position = slot.position
	slot.place(card, player)

func endTurn():
	canPlay = false

func enemyTurn(slot, card):
	add_child(card)
	playCard(slot, card, "B", false)
	drawCard()
	reorganize()
	canPlay = true