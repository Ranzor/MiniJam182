extends Node

signal level_completed
signal game_over

var living_frogs = []
var frogs_at_exit = []
var next_level : PackedScene

func register_frog(frog) -> void:
	if not frog in living_frogs:
		living_frogs.append(frog)

func unregister_frog(frog) -> void:
	if frog in living_frogs:
		living_frogs.erase(frog)
		check_victory(next_level)		
	if frog in frogs_at_exit:
		frogs_at_exit.erase(frog)

func frog_reached_exit(frog, next) -> void:
	print(frog)
	if not frog in frogs_at_exit:		
		frogs_at_exit.append(frog)
		print(frogs_at_exit)
		if next: next_level = next
		check_victory(next_level)

func frog_left_exit(frog) -> void:
	if frog in frogs_at_exit:
		frogs_at_exit.erase(frog)
	
func check_victory(next : PackedScene) -> void:
	if living_frogs.size() > 0 and living_frogs.size() == frogs_at_exit.size():
		level_completed.emit()
		if next:
			Global.reset_possession_state()
			living_frogs.clear()
			frogs_at_exit.clear()
			get_tree().change_scene_to_packed(next)
	elif living_frogs.size() <= 0:
		game_over.emit()
