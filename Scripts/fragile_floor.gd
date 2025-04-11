extends StaticBody2D

@export var sprite : Sprite2D
@export var anim : AnimationPlayer

func _process(delta: float) -> void:
	sprite.modulate = Global.current_colors[Global.color_scheme].primary
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("frog") and body.is_heavy:
		anim.play("crumble")
		await anim.animation_finished
		queue_free()
