extends Area2D

signal coin_collected

func _ready():
	pass # Replace with function body.

func hide_coin():
	set_collision_mask_bit(0, false)
	hide()
	
func show_coin():
	set_collision_mask_bit(0, true)
	show()
	
func _on_Area2D_body_entered(body):
	emit_signal("coin_collected")
	hide_coin()
