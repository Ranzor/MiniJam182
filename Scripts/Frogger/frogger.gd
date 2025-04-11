extends CharacterBody2D
@export var sprite : Sprite2D

func _process(delta: float) -> void:
	move()

func move():
	if Input.is_action_just_pressed("ui_up"):
		global_position.y -= 16
		sprite.flip_h = false
		sprite.flip_v = false
		global_rotation_degrees = 0
	if Input.is_action_just_pressed("ui_down"):
		global_position.y += 16
		sprite.flip_h = false
		sprite.flip_v = true
		global_rotation_degrees = 0
		
	if Input.is_action_just_pressed("ui_left"):
		global_position.x -= 16
		sprite.flip_h = false
		sprite.flip_v = true
		global_rotation_degrees = 90
	if Input.is_action_just_pressed("ui_right"):
		global_position.x += 16
		sprite.flip_h = false
		sprite.flip_v = false
		global_rotation_degrees = 90
