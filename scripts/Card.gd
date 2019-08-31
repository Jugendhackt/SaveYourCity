extends Sprite

onready var moveTween = $Tween
onready var sprite = $Sprite

func move(target):
	moveTween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_CUBIC, Tween.EASE_OUT)