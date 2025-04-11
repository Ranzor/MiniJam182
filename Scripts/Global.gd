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
	ColorScheme.GHOST: {primary = Color.WHITE, secondary = Color.BLACK},
	ColorScheme.GREEN: {primary = Color.GREEN, secondary = Color.DARK_GREEN},
	ColorScheme.YELLOW: {primary = Color.YELLOW, secondary = Color.DARK_GOLDENROD},
	ColorScheme.RED: {primary = Color.RED, secondary = Color.DARK_RED}
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

func _process(_delta: float) -> void:
	RenderingServer.set_default_clear_color(current_colors[color_scheme].secondary)
