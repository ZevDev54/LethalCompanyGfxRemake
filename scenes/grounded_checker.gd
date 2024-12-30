class_name GroundedChecker
extends Area3D

var grounded: bool = false

# Function to handle when a body enters the Area3D
func _on_body_entered(body):
	# Ensure the detected body is not the player itself
	if body.is_in_group("ground"):  # Assuming you have a group for ground objects
		grounded = true

# Function to handle when a body exits the Area3D
func _on_body_exited(body):
	if body.is_in_group("ground"):
		grounded = false

func is_grounded() -> bool:
	print("Grounded checker says: grounded is "+str(grounded))
	return grounded