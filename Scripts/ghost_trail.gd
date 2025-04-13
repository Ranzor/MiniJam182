extends Sprite2D
var fade_time = 0.2
var max_lifetime = 1.0

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate:a", 0.0,fade_time).set_ease(Tween.EASE_IN)
	
	await get_tree().create_timer(max_lifetime).timeout
	queue_free()
