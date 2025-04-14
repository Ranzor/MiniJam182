extends Node2D

@export var fade_distance = 400.0
@export var base_scale = 0.5

@export var sprite : Sprite2D

var target_frog : Node2D
var ghost : Node2D


func _process(_delta: float) -> void:
	if !target_frog || !ghost:
		queue_free()
		return
		
	var to_frog = target_frog.global_position - ghost.global_position
	rotation = to_frog.angle()
	
	global_position = ghost.global_position + (to_frog.normalized() * 30)
	
	var distance = to_frog.length()
	var alpha = remap(distance, 0, fade_distance, 1.0,0.4)
	modulate.a = clamp(alpha, 0.3,1.0)
	
	var scale_factor = remap(distance,0, fade_distance, base_scale*0.8, base_scale*1.2)
	scale = Vector2.ONE * scale_factor
