extends AudioStreamPlayer

const game_music = preload("res://Audio/new_song2.wav")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return

	stream = music
	volume_db = volume
	
	play()
	
func play_fx(fx: AudioStream):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = fx
	fx_player.volume_db = Global.fxVolume
	fx_player.name = "FX_PLAYER"
	add_child(fx_player)
	fx_player.play()
	await fx_player.finished
	fx_player.queue_free()
	
func play_music_game():
	pass
	_play_music(game_music,Global.musicVolume)
	#track = 1
func set_volume(newVol: float):
	volume_db = newVol	
	
func play_fx_click():
	var click = load("res://Audio/click.wav")
	play_fx(click)
