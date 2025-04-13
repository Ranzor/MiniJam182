extends Node2D

@export var sprites : Array[Sprite2D] = []
var can_anim = true

var speed = 20
func _process(delta: float) -> void:
	global_position.x -= speed * delta
	if global_position.x <= 150:
		global_position.x = 539
		
	if can_anim:
		animate()


func animate():
	can_anim = false
	for sprite in sprites:
		if sprite.frame == 4:
			sprite.frame = 5
		else:
			sprite.frame = 4
	await get_tree().create_timer(0.2).timeout
	can_anim = true
