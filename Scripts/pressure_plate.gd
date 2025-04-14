extends Area2D

signal pressed
signal released

@export var sprite : Sprite2D
@export var toggle_plate = false
@export var require_heavy = true
@export var anim : AnimationPlayer


var is_active = false


func _ready() -> void:
	sprite.frame = 0

func _process(_delta: float) -> void:
	sprite.modulate = Global.current_colors[Global.color_scheme].primary

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("frog") and body.is_heavy:
		anim.play("pressed")
		pressed.emit()
	elif body.is_in_group("frog") and not require_heavy:
		anim.play("pressed")
		pressed.emit()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("frog"):
		if not toggle_plate:
			anim.play("unpressed")
			released.emit()
