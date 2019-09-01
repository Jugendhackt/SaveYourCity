extends Sprite

signal slot_released

export var maxStackSize = 5

var type = "Defensive"
var player = "A"
var stack = 0

var occupant

func init(type, player):
	self.type = type
	self.player = player
	if player == "A":
		set_texture(load("res://sprites/blau.png"))

func canPlace(card, player):
	return (self.player == player and type == card.type and !occupant) or (occupant and occupant.cardName == card.cardName and stack < maxStackSize) 

func place(card, player):
	if !occupant:
		occupant = card
	else:
		stack += 1
	card.onPlace(player)

func _on_MouseArea_input_event(viewport, event, shape_idx):
	if event.is_action_released("game_click"):
		emit_signal("slot_released", self)
