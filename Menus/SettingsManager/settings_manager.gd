extends Node

const CONFIG_PATH := "user://settings.cfg"

var video_settings := {
	"resolution" : Vector2i(1280,720),
	"fullscreen" : false,
	"borderless" : false,
	"vsync" : true
}

var audio_settings := {
	"master_volume" : .5,
	"music_volume" : .5,
	"sfx_volume" : .5,
	"voice_volume" : .5
}

var control_settings := {
	"up" : "W",
	"down" : "S",
	"left" : "A",
	"right" : "D",
	"inventory" : "E"
}
