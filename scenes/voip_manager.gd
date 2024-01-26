class_name voip_manager
extends Node3D

# @export var input : AudioStreamPlayer3D;
@onready var input = $InputStream;

@export var output : AudioStreamPlayer3D;
@export var inputThreshold := 0.005;

var index : int;
var effect : AudioEffectCapture

var playback : AudioStreamGeneratorPlayback;






func setupAudio(id):
	set_multiplayer_authority(id);

	if is_multiplayer_authority():
		input = $InputStream
		input.stream = AudioStreamMicrophone.new();
		input.play();
		index = AudioServer.get_bus_index("Record");
		effect = AudioServer.get_bus_effect(index, 0);

	
	output.play()
	playback = output.get_stream_playback()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#process mic info is is local payer authority.
	if is_multiplayer_authority():
		processMic();
	pass

func processMic():
	#get raw data, this is stereo audio hence vector2
	var stereoData : PackedVector2Array = effect.get_buffer(effect.get_frames_available())

	#if there is any data..
	if stereoData.size() > 0:
		var data = PackedFloat32Array()
		data.resize(stereoData.size())
		var maxAmplitude := 0.0;

		#Convert stereo to mono audio
		for i in range(stereoData.size()):
			var value = (stereoData[i].x + stereoData[i].y)/2
			maxAmplitude = max(value, maxAmplitude);
			data[i] = value
		
		#Return if mic data too quiet
		if maxAmplitude < inputThreshold:
			return;
		print(data);
