extends CharacterBody2D
@export var sprite : Sprite2D
var move_distance = 17
var can_move = true

func _process(delta: float) -> void:
	if global_position.y <= 495:
		can_move = false

func _unhandled_input(event: InputEvent) -> void:
	if !can_move:
		return
		
		
	if event.is_action_pressed("ui_up"):
		move(Vector2.UP)
	elif event.is_action_pressed("ui_down"):
		move(Vector2.DOWN)
	elif event.is_action_pressed("ui_left"):
		move(Vector2.LEFT)
	elif event.is_action_pressed("ui_right"):
		move(Vector2.RIGHT)

func move(direction : Vector2) -> void:
	can_move = false
	sprite.frame = int(!bool(sprite.frame))
	
	match direction:
		Vector2.UP:
			sprite.rotation_degrees = 0
			sprite.flip_v = false
	match direction:
		Vector2.DOWN:
			sprite.rotation_degrees = 0
			sprite.flip_v = true
	match direction:
		Vector2.LEFT:
			sprite.rotation_degrees = -90
			sprite.flip_h = true
	match direction:
		Vector2.RIGHT:
			sprite.rotation_degrees = 90
			sprite.flip_h = false
	global_position += direction * move_distance
	await get_tree().create_timer(0.1).timeout
	can_move = true
	print(global_position.y)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("DEAD DUUUUD")
	## TODO: Animation to transition to game
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
