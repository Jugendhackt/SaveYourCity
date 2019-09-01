extends Sprite

onready var moveTween = $Tween

export var type = "Defensive"
export var cardName = "Card"

export var effects = Vector3(0, 0, 0)
export var health = 10
export var onPlaceFunc = "on_place"
export var imagePath = "res://sprites/Baum.png"

var placed = false

signal card_clicked(card)

func move(target):
	moveTween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	moveTween.start()

func onPlace(player):
	call(onPlaceFunc, player)
	placed = true

func on_place(player):
	var getPlayer = get_parent().get_parent().get_node("Player" + player)
	var interface = get_parent().get_parent().get_node("Interface" + player)
	
	getPlayer.people += effects.x
	getPlayer.air += effects.y
	getPlayer.energy += effects.z
	
	interface.get_node("Bars/InhabitantsBar").updateInhabitants(getPlayer.people)
	interface.get_node("Bars/AirBar").updateAir(getPlayer.air)
	interface.get_node("Bars/EnergyBar").updateEnergy(getPlayer.energy)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT and !placed:
		emit_signal("card_clicked", self)


func on_place_attacker(player):
	pass
