extends Area2D

signal pressed

@export var sprite : Sprite2D
@export var anim : AnimationPlayer
var is_active = false

func on_hit():
	if not is_active:
		anim.play("hit")
		pressed.emit()
		is_active = true
	
	
func _process(_delta: float) -> void:
	sprite.modulate = Global.current_colors[Global.color_scheme].primary
