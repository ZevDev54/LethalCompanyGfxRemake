extends GPUParticles3D

@export var follow : Node3D;
@export var lerpSpeed := 1.0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = global_position.lerp(follow.global_position, lerpSpeed * delta)