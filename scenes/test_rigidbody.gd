extends RigidBody3D

func _physics_process(delta):
	apply_central_force(Vector3.FORWARD*50);