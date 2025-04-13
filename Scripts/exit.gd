extends Area2D

@export var next_level : PackedScene
@export var sprite : Sprite2D

func _process(delta: float) -> void:
	sprite.modulate = Color("00FFFF")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("frog"):
		LevelManager.frog_reached_exit(body)



func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("frog"):
		LevelManager.frog_left_exit(body)
