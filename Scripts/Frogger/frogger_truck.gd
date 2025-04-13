extends CharacterBody2D
var speed = 60
func _process(delta: float) -> void:
	global_position.x -= speed * delta
	if global_position.x <= 150:
		global_position.x = 539
