extends AudioListener2D
@export var frogger_theme : AudioStreamWAV
@export var main_theme : AudioStreamWAV

@export var audio : AudioStreamPlayer

func change_music(new_track: AudioStream, fade_duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(audio, "volume_db", -30.0, fade_duration)
	await tween.finished
	audio.stream = new_track
	audio.play()
	tween = create_tween()
	tween.tween_property(audio, "volume_db", -10.0, fade_duration)
