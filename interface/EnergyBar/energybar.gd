extends HBoxContainer

signal maximum_changed(maximum)

var maximum = 100
var current_energy = 0

func initialize(max_value):
	maximum = max_value
	emit_signal("maximum_changed", maximum)

func updateEnergy(new_energy):
	animate_value(current_energy, new_energy)
	update_count_text(new_energy)
	current_energy = new_energy

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "update_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")

func update_count_text(value):
	$Count/Number.text = str(round(value)) + '/' + str(maximum)
