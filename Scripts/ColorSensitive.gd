extends Node2D
class_name ColorSensitive

@export var required_schemes : Array[Global.ColorScheme]
@export var active = true
@export var sprite : Sprite2D
@export var col : CollisionShape2D


func _draw() -> void:
	Global.color_scheme_changed.connect(_update_visibility)
	_update_visibility()
	
func _update_visibility():
	var should_show = active && (Global.color_scheme in required_schemes)
	set_visual_visibility(should_show)
	set_collision_visibility(should_show)

func set_visual_visibility(vis : bool):
	if sprite:
		sprite.visible = vis
		
func set_collision_visibility(vis : bool):
	if col:
		col.disabled = !vis
		
func _process(delta: float) -> void:
	sprite.modulate = Global.current_colors[Global.color_scheme].primary
