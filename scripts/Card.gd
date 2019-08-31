extends Sprite

onready var moveTween = $Tween

export var type = "Defensive"
export var cardName = "Card"

export var effects = Vector3(0, 0, 0)

signal card_clicked(card)

func move(target):
	moveTween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	moveTween.start()

func onPlace(player):
	get_parent().get_node("Player" + player).people += effects.x
	get_parent().get_node("Player" + player).air += effects.y
	get_parent().get_node("Player" + player).energy += effects.z

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("card_clicked", self)
