extends CharacterBody2D
@export var sprite : Sprite2D
var move_distance = 17
var can_move = true
@export var transition : PackedScene
@export var audio : AudioStreamPlayer2D
@export var jmp_snd : AudioStreamWAV
@export var hit_snd : AudioStreamWAV

func _process(delta: float) -> void:
	can_move = !Global.frogger_dead
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
	audio.stream = jmp_snd
	audio.play()
	await get_tree().create_timer(0.1).timeout
	can_move = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	on_death_trigger()
	
func on_death_trigger():
	Global.frogger_dead = true
	audio.stream = hit_snd
	audio.play()
	var tween = create_tween()
	var ghost = transition.instantiate()
	ghost.global_position = global_position
	get_parent().add_child(ghost)
	
	tween.tween_method(_flicker_sprite, 0.0, 1.0, 1.0)
	await tween.finished
	queue_free()
	
	
func _flicker_sprite(progress: float):
	sprite.visible = fmod(progress * 10, 2.0) < 1.0
	sprite.modulate.a = 1.0 - progress
