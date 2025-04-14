extends Sprite2D
var init_pos
var fade_distance = 200.0
var is_moving = false
func _ready() -> void:
	init_pos = global_position
	scale = Vector2.ZERO
	modulate.a = 0.0
	
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2.ONE, 3)
	tween.parallel().tween_property(self, "modulate:a", 1.0, 3 * 0.5)
	
	## TODO: Sound Effect
	await tween.finished
	is_moving = true



func _process(delta: float) -> void:

	if !is_moving: return
	
	global_position.y -= 50 * delta
	var distance_traveled = init_pos.y - global_position.y
	var fade = 1.0 - clamp(distance_traveled / fade_distance, 0.0, 10.0)
	modulate.a = fade


	if modulate.a <= 0.0:
		var fade_out = preload("res://Scenes/Frogger/fade.tscn").instantiate()
		get_tree().root.add_child(fade_out)
		fade_out.fade_out()
		await fade_out.fade_completed
		var next = Sound.main_theme
		Sound.change_music(next)
		get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
		queue_free()
