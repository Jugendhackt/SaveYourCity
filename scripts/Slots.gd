extends Node2D

export var padding = Vector2(10, 100)
export var xOffIncrement = 30
export var xOffStart = 50

var slots = []

onready var xOff = xOffStart

func _ready():
	for i in range(0, 4):
		addSlot("Defensive", "A")
	xOff += xOffIncrement
	addSlot("Offensive", "A")
	addSlot("Offensive", "B")
	xOff += xOffIncrement
	for i in range(0, 4):
		addSlot("Defensive", "B")
	
func addSlot(type, player):
	var slot = load("res://scenes/Slot.tscn").instance()
	slot.init(type, player)
	print(slot.get_texture().get_size().x)
	slot.position = Vector2(xOff + (padding.x + slot.get_texture().get_size().x * slot.transform.get_scale().x) * slots.size(), position.y + padding.y)
	add_child(slot)
	slots.append(slot)
	slot.connect("slot_released", get_parent().get_node("HandCards"), "_on_slot_released")