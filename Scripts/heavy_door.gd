extends StaticBody2D

@export var anim : AnimationPlayer
@export var sprite : Sprite2D
@export var plate : Area2D

func _ready() -> void:
	plate.connect("pressed",open)
	plate.connect("released",closed)
	closed()
	
func _process(delta: float) -> void:
	sprite.modulate = Global.current_colors[Global.color_scheme].primary

func open():
	anim.play("open")
	pass
	
func closed():
	anim.play("closed")
	pass
