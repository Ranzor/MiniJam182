extends Area2D

@export var next_level : PackedScene
@export var sprite : Sprite2D

func _process(_delta: float) -> void:
	sprite.modulate = Color("00FFFF")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("frog"):
		LevelManager.frog_reached_exit(body,next_level)



func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("frog"):
		LevelManager.frog_left_exit(body)
