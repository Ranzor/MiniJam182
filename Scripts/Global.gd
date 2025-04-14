extends Node

enum FrogAbilities {NONE, JUMP_HIGH, WALL_JUMP, DASH, HEAVY, TONGUE_GRAB, TONGUE}
enum ColorScheme {GHOST, GREEN, YELLOW, RED}
enum PossessionState {
	GHOST,
	POSSESSING
}
var state : PossessionState = PossessionState.GHOST
var current_possessed = null
var ghost_scene = preload("res://Scenes/ghost.tscn")

var current_colors = {
	ColorScheme.GHOST: {primary = Color("F0F0F0"), secondary = Color("303030")},
	ColorScheme.GREEN: {primary = Color("6A994E"), secondary = Color("0F2009")},
	ColorScheme.YELLOW: {primary = Color("FFE600"), secondary = Color("382E00")},
	ColorScheme.RED: {primary = Color("D62828"), secondary = Color("260101")}
}

var color_scheme : ColorScheme = ColorScheme.GHOST:
	set(value):
		color_scheme = value
		color_scheme_changed.emit()

signal color_scheme_changed

const BASE_SPEED = 120
const BASE_JUMP_FORCE = -300
const GHOST_SPEED = 150
var last_possession_time = 0

var frogger_dead = false

func refresh_color_scheme():
	color_scheme_changed.emit()
	
func reset_possession_state():
	state = PossessionState.GHOST
	color_scheme = ColorScheme.GHOST
	current_possessed = null
	last_possession_time = 0

func _process(_delta: float) -> void:
	RenderingServer.set_default_clear_color(current_colors[color_scheme].secondary)
