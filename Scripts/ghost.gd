extends CharacterBody2D

const SPEED = 100
@export var anim : AnimationPlayer
@export var sprite : Sprite2D
@export var camera : Camera2D

var can_possess = false
var possess_target : CharacterBody2D


func _ready() -> void:
	if camera:
		camera.make_current()
		CameraManager.current_camera = camera
	
	Global.connect("color_scheme_changed", update_color)
	update_color()

func _physics_process(delta: float) -> void:
		if Global.state == Global.PossessionState.GHOST:
			handle_ghost_movement(delta)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("frog"): ## TODO: and Input.is_action_just_pressed("possess"): AKA Add state for button prompt
		can_possess = true
		possess_target = body
		
func update_color():
	sprite.modulate = Global.current_colors[Global.color_scheme].primary
	pass
	
func handle_ghost_movement(_delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input * Global.GHOST_SPEED
	
	move_and_slide()

	if input.x != 0:
		anim.play("move")
		#position.y += sin(Time.get_ticks_msec() * 0.01) * 0.5
	else:
		anim.play("idle")
		
	if input.x < 0:
		sprite.flip_h = true
	elif input.x > 0:
		sprite.flip_h = false
	
	
	
	pass
	
func possess_frog(frog):
	CameraManager.transition_to(frog.camera)
	Global.state = Global.PossessionState.POSSESSING
	Global.color_scheme = frog.frog_color_scheme
	Global.current_possessed = frog
	Global.last_possession_time = Time.get_ticks_msec()
	frog.possessed = true
	frog.camera.make_current()
	
	queue_free()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("frog"):
		can_possess = false
		possess_target = null

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("possess") and can_possess:
		possess_frog(possess_target)
