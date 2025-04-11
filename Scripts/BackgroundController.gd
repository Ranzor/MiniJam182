extends CanvasModulate

func _ready():
	Global.connect("color_scheme_changed", update_colors)
	update_colors()
	
func update_colors():
	color = Global.current_colors[Global.color_scheme].secondary
