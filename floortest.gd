extends StaticBody2D


func _process(_delta: float) -> void:
	$Sprite2D.modulate = Global.current_colors[Global.color_scheme].primary
