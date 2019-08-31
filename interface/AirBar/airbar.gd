extends HBoxContainer

signal maximum_changed(maximum)

var maximum = 100
var current_air = 0

func initialize(max_value):
	maximum = max_value
	emit_signal("maximum_changed", maximum)

func updateAir(new_air):
	animate_value(current_air, new_air)
	update_count_text(new_air)
	current_air = new_air

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "update_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")

func update_count_text(value):
	$Count/Number.text = str(round(value)) + '/' + str(maximum)
