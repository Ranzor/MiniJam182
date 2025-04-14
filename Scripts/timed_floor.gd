extends StaticBody2D

@export var sprite : Sprite2D
@export var anim : AnimationPlayer
@export var timer : Timer
@export var timer2 : Timer

func _process(_delta: float) -> void:
	sprite.modulate = Global.current_colors[Global.color_scheme].primary


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("frog"):
		timer.start()
		pass # Replace with function body.


func _on_timer_timeout() -> void:
	anim.play("fade_out")
	await anim.animation_finished
	timer2.start()
	pass


func _on_timer_2_timeout() -> void:
	anim.play("fade_in")
	pass # Replace with function body.
