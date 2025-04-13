extends Path2D

@export var speed = 50.0
@export var active_color : Global.ColorScheme = Global.ColorScheme.GHOST
@export var pause_at_ends = true

@export var path_follow : PathFollow2D
@export var platform : Node
@export var trigger : Area2D
@export var sprite : Sprite2D

var riders = []

var direction = 1
@export var is_moving = true
var last_position : Vector2

func _ready() -> void:
	sprite.modulate = Global.current_colors[active_color].primary
	if trigger:
		trigger.connect("pressed",move)
		trigger.connect("released",stop)
	last_position = path_follow.global_position
	if curve != null:
		queue_redraw()
		
func _process(delta: float) -> void:
	if !is_moving || Global.color_scheme != active_color:
		return

	var prev_position = path_follow.global_position
	
	path_follow.progress += speed * delta * direction
	
	var delta_move = path_follow.global_position - prev_position
	for rider in riders:
		rider.global_position += delta_move
	
	if path_follow.progress_ratio >= 1.0:
		if pause_at_ends:
			is_moving = false
			await get_tree().create_timer(0.5).timeout
			is_moving = true
		direction = -1 if pause_at_ends else 0
		
	elif path_follow.progress_ratio <= 0.0:
		if pause_at_ends:
			is_moving = false
			await get_tree().create_timer(0.5).timeout
			is_moving = true
		direction = 1
		
	last_position = path_follow.global_position


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("frog"):
		riders.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in riders:
		riders.erase(body)
		
func move():
	is_moving = true
	
func stop():
	is_moving = false
