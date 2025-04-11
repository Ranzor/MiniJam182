extends Node

var current_camera : Camera2D

func transition_to(cam: Camera2D, smooth = true):
	if current_camera:
		current_camera.enabled = false
		
	current_camera = cam
	cam.enabled = true
	cam.make_current()
	
	if smooth:
		var tween = create_tween().set_trans(Tween.TRANS_QUINT)
		tween.tween_property(cam, "zoom", Vector2(1,1),0.8)
