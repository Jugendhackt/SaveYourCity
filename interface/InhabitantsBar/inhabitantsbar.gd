extends HBoxContainer

signal maximum_changed(maximum)

var maximum = 100
var current_inhabitants = 0

func initialize(max_value):
	maximum = max_value
	emit_signal("maximum_changed", maximum)

func updateInhabitants(new_inhabitants):
	animate_value(current_inhabitants, new_inhabitants)
	update_count_text(new_inhabitants)
	current_inhabitants = new_inhabitants
	rpc("_update_inhabitants", current_inhabitants)
	
remote func _update_op_inhabitants(new_inhabitants):
	animate_value(current_inhabitants, new_inhabitants)
	update_count_text(new_inhabitants)
	current_inhabitants = new_inhabitants
	
func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "update_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")

func update_count_text(value):
	$Count/Number.text = str(round(value)) + '/' + str(maximum)
	
func animate_op_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "update_op_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")

func update_op_count_text(value):
	$Count/Number.text = str(round(value)) + '/' + str(maximum)
