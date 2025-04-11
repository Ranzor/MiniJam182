extends CharacterBody2D

@export var frog_color_scheme = Global.ColorScheme.GREEN
@export var abilities : Array[Global.FrogAbilities] = []
@export var speed = 1
@export var jump_modifier = 1
@export var max_tongue_length = 300
@export var tongue_speed = 1000
@export var tongue_retract_time = 0.2

@export var camera : Camera2D

@export var anim : AnimationPlayer
@export var sprite : Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var possessed = false
var current_jumps = 1
var is_heavy = false
var grabbed_object : RigidBody2D = null
var is_attacking = false

@onready var tongue_line = %TongueLine
@onready var tongue_end = %TongueEnd

func _ready() -> void:
	LevelManager.register_frog(self)
	sprite.modulate = Global.current_colors[frog_color_scheme].primary
	tongue_end.modulate = Global.current_colors[frog_color_scheme].primary
	tongue_line.default_color = Global.current_colors[frog_color_scheme].primary
	camera.enabled = false
	if Global.FrogAbilities.HEAVY in abilities:
		speed = 0.6
		jump_modifier = 0.5
		is_heavy = true
		
	
func _process(delta: float) -> void:
	
	if possessed:
		if not is_attacking:
			handle_movement(delta)
		handle_abilities(delta)
		update_visuals()
		
		if tongue_end.visible and tongue_line.get_point_count() >= 2:
			tongue_line.set_point_position(1, tongue_end.position)
		
		var time_since_possess = Time.get_ticks_msec() - Global.last_possession_time
		if Input.is_action_just_pressed("possess") and possessed and time_since_possess > 100:
			Global.state = Global.PossessionState.GHOST
			Global.color_scheme = Global.ColorScheme.GHOST
			Global.current_possessed = null
			possessed = false
			anim.play("idle")
			
			var spawn = Global.ghost_scene.instantiate()
			spawn.global_position = global_position + Vector2(0,-16)
			get_tree().current_scene.add_child(spawn)
			CameraManager.transition_to(spawn.camera)
	else:
		velocity.y += gravity * delta
		velocity.x = 0
		## TODO: Add friction when unpossessed from the airas
		move_and_slide()

func handle_movement(delta):
	var input = Input.get_axis("ui_left","ui_right")
	velocity.x = input * Global.BASE_SPEED * speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		current_jumps = 1 if Global.FrogAbilities.JUMP_HIGH in abilities else 0
	
	if velocity.x != 0:
		anim.play("move")
	elif not is_attacking:
		anim.play("idle")
	pass
	
	move_and_slide()

func handle_abilities(_delta):
	if Global.FrogAbilities.TONGUE_GRAB in abilities:
		if grabbed_object:
			#var direction = {tongue_tip.global_position - grabbed_object.global_position).normalized()
			#grabbed_object.apply_central_impulse(direction * 400 * delta)
			pass
			
func _input(event: InputEvent) -> void:
	if possessed:
		if Input.is_action_just_pressed("jump"):
			try_jump()
		if Global.FrogAbilities.TONGUE_GRAB in abilities:
			if event.is_action_pressed("ability"):
				try_grab_object()
			elif event.is_action_released("ability"):
				release_grab()
		if event.is_action_pressed("ability") and Global.FrogAbilities.TONGUE in abilities and is_on_floor():
			tongue_attack()
			
func try_jump():
	if is_on_floor():
		velocity.y = Global.BASE_JUMP_FORCE
		if Global.FrogAbilities.JUMP_HIGH in abilities:
			current_jumps = 1
	elif Global.FrogAbilities.JUMP_HIGH in abilities and current_jumps > 0:
		velocity.y = Global.BASE_JUMP_FORCE * 0.8
		current_jumps -= 1
		
func update_visuals():
	sprite.flip_h = velocity.x < 0 if velocity.x != 0 else sprite.flip_h

func try_grab_object():
	## TODO: Grab Object
	pass

func release_grab():
	pass

func tongue_attack():
	is_attacking = true
	var direction = Vector2.LEFT if sprite.flip_h else Vector2.RIGHT
	var hit_result = detect_tongue_hit(direction)
	var hit_point = hit_result.get("position", global_position + direction * max_tongue_length)
	
	if hit_result.has("collider"):
		var target = hit_result["collider"]
		if target.get_parent().has_method("on_hit"):
			target.get_parent().on_hit()
	
	animate_tongue(direction, hit_point)

func detect_tongue_hit(direction: Vector2) -> Dictionary:
	var params = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + direction * max_tongue_length,
		collision_mask
	)
	return get_world_2d().direct_space_state.intersect_ray(params)

func animate_tongue(_direction, target_pos):
	
	anim.play("attack")
	
	var target_length = global_position.distance_to(target_pos)
	var local_target = to_local(target_pos)
	
	tongue_line.clear_points()
	tongue_line.add_point(Vector2.ZERO)
	tongue_line.add_point(Vector2.ZERO)
	tongue_end.position = Vector2.ZERO
	tongue_line.visible = true
	
	var extend_time = target_length / tongue_speed
	var tween = create_tween().set_parallel(true)
	tween.tween_property(tongue_end, "position", local_target, extend_time)
	
	await tween.finished
	tween = create_tween().set_parallel(true)
	tween.tween_property(tongue_end, "position", Vector2.ZERO, tongue_retract_time)
	
	await tween.finished
	tongue_line.visible = false
	
	
	
	
	is_attacking = false
