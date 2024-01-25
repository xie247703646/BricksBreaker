extends Node

enum Bus{
	Master,
	Sound,
	Music
}

var sound_dic = {
	"dong":preload("res://asset/audio/dong.wav"),
	"ding":preload("res://asset/audio/ding.mp3"),
	"bo":preload("res://asset/audio/bo.mp3")
}

var music_dic = {
	"bgm":preload("res://asset/audio/bgm.mp3")
}

const MIN_VOLUME = -80
const MAX_VOLUME = 24
const MAX_SOUND_CNT = 10

var cur_music:Dictionary = {
	"player":null,
	"name":null
}

var sfx_container:Node
var music_container:Node

func _ready() -> void:
	pause_mode = Node.PAUSE_MODE_PROCESS
	set_sound_mute(not Setting.sfx_enabled)
	set_music_mute(not Setting.music_enabled)
	sfx_container = Node.new()
	sfx_container.name = "Sfx"
	add_child(sfx_container)
	
	music_container = Node.new()
	music_container.name = "Music"
	add_child(music_container)

func play_sfx(sound_name:String,force:bool = false)->void:
	if is_sound_muted(): return
	if not force and sfx_container.get_child_count() > MAX_SOUND_CNT: return
	if not sound_dic.has(sound_name):
		printerr("不存在音效%s" % sound_name)
		return
	var sound_player:AudioStreamPlayer = AudioStreamPlayer.new()
	sound_player.bus = "Sound"
	sound_player.stream = sound_dic[sound_name]
	sound_player.autoplay = true
	sound_player.connect("finished",sound_player,"queue_free")
	sfx_container.add_child(sound_player)

func play_sound_by_stream(stream:AudioStreamSample)->void:
	var sound_player:AudioStreamPlayer = AudioStreamPlayer.new()
	sound_player.bus = "Sound"
	sound_player.stream = stream
	sound_player.autoplay = true
	sound_player.connect("finished",sound_player,"queue_free")
	sfx_container.add_child(sound_player)

func has_music()->bool:
	return cur_music.name != null

func play_music(music_name:String)->void:
	if not music_dic.has(music_name):
		printerr("不存在音乐%s" % music_name)
		return
	if cur_music.name != music_name:
		cur_music.name = music_name
		var music_player = cur_music.player
		if not music_player: music_player = AudioStreamPlayer.new()
		music_player.bus = "Music"
		music_player.stream = music_dic[music_name]
		music_player.autoplay = true
		cur_music.player = music_player
		music_container.add_child(music_player)

func stop_music()->void:
	if not has_music(): return
	var music_player:AudioStreamPlayer = cur_music.player
	music_player.free()
	cur_music.name = null
	cur_music.player = null

func pause_music()->void:
	if not has_music(): return
	var music_player:AudioStreamPlayer = cur_music.player
	music_player.stream_paused = true

func resume_music()->void:
	if not has_music(): return
	var music_player:AudioStreamPlayer = cur_music.player
	music_player.stream_paused = false

func set_music_mute(mute:bool,save:bool = true)->void:
	AudioServer.set_bus_mute(Bus.Music,mute)
#	SaveMgr.set_value(CONFIG_SECTION,"music_mute",mute,save)

func set_music_volume(volume:float,save:bool = true)->void:
	AudioServer.set_bus_volume_db(Bus.Music,volume)
#	SaveMgr.set_value(CONFIG_SECTION,"music_volume",volume,save)

func set_sound_mute(mute:bool,save:bool = true)->void:
	AudioServer.set_bus_mute(Bus.Sound,mute)
#	SaveMgr.set_value(CONFIG_SECTION,"sound_mute",mute,save)

func set_sound_volume(volume:float,save:bool = true)->void:
	AudioServer.set_bus_volume_db(Bus.Sound,volume)
#	SaveMgr.set_value(CONFIG_SECTION,"sound_volume",volume,save)

func get_music_volume()->float:
	return AudioServer.get_bus_volume_db(Bus.Music)

func get_sound_volume()->float:
	return AudioServer.get_bus_volume_db(Bus.Sound)

func is_music_muted()->bool:
	return AudioServer.is_bus_mute(Bus.Music)

func is_sound_muted()->bool:
	return AudioServer.is_bus_mute(Bus.Sound)

func _on_sound_finished(sound:AudioStreamPlayer)->void:
	sound.queue_free()

#func clear()->void:
#	var audio_arr = get_children()
#	for audio in audio_arr:
#		audio.free()

func clear_sfx()->void:
	var sfx_arr:Array = sfx_container.get_children()
	for sfx in sfx_arr: sfx.queue_free()

