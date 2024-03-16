extends Node3D

@export var lantern : PackedScene;
@export var throwPower = 15;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("lantern"):
		var spawned = lantern.instantiate();
		# get_tree().add_child(spawned);
		# spawned.set_global_transform(new Transform3D(self.get_global_transform().basis, global_position));
		owner.get_parent().add_child(spawned)
		spawned.global_transform.origin = self.global_position;
		# spawned.global_position = self.global_position;
		var rb = spawned as RigidBody3D;

		var rot = get_global_transform().basis
		rb.apply_impulse(-rot.z * throwPower);


