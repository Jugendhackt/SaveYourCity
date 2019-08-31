extends Sprite

onready var moveTween = $Tween

func move(target):
	moveTween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_CUBIC, Tween.EASE_OUT)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		print("Clicked Card")

