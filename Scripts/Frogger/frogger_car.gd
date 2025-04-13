extends CharacterBody2D
var speed = 40
@export var sprite : Sprite2D
func _process(delta: float) -> void:
	if sprite.flip_h:
		global_position.x += speed * delta
		if global_position.x >= 540:
			global_position.x = 151
		
	else:
		global_position.x -= speed * delta
		if global_position.x <= 150:
			global_position.x = 539
	pass
