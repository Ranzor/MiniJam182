extends CanvasLayer

signal fade_completed
@export var anim : AnimationPlayer
@export var colRec : ColorRect
func fade_in():
	await get_tree().process_frame
	print("fading")
	colRec.modulate.a = 1.0
	
	Engine.time_scale = 0.1
	anim.play("fade_in")
	await anim.animation_finished
	emit_signal("fade_completed")
	Engine.time_scale = 1.0
	queue_free()
	
func fade_out():
	Engine.time_scale = 0.5
	anim.play("fade_out")
	await anim.animation_finished
	emit_signal("fade_completed")
	Engine.time_scale = 1.0
	queue_free()
