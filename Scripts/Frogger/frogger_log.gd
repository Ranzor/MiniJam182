extends Sprite2D
var speed = 20
func _process(delta: float) -> void:
	if Global.frogger_dead : return
	global_position.x += speed * delta
	if global_position.x >= 590:
		global_position.x = 109
