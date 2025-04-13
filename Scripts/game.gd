extends Node2D
func _ready() -> void:
	var fade = preload("res://Scenes/Frogger/fade.tscn").instantiate()
	fade.colRec.modulate.a = 1.0
	add_child(fade)
	fade.fade_in()
	print("waiting")
	await fade.fade_completed
	print("faded")
	fade.queue_free()
