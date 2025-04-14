extends StaticBody2D

@export var area : Area2D

func _process(_delta: float) -> void:
	for body in area.get_overlapping_bodies():
		if body.is_in_group("frog"):
			body.on_platform = true
