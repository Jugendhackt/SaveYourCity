extends Sprite

onready var moveTween = $Tween
export var test = 10

func move(target):
	moveTween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	
