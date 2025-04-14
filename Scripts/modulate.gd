extends Label
func _process(_delta: float) -> void:
	modulate = Global.current_colors[Global.color_scheme].primary
