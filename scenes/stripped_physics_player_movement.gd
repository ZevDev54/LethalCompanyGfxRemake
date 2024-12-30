extends RigidBody3D

@export var groundedChecker : GroundedChecker

# Movement parameters
@export var speed = 10.0
@export var jump_strength = 15.0
@export var gravity = -9.8
@export var max_speed = 20.0

# Input handling
var move_dir = Vector3()
# var is_grounded = false

# Camera reference for direction (assign in the editor)
@export var camera : Camera3D;



func _enter_tree():
	set_multiplayer_authority(str(name).to_int(), true)

func _ready():
	if !is_multiplayer_authority(): return;

	# Set custom gravity (optional)
	set_linear_velocity(Vector3(0, gravity, 0))
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.current = true;

	PlayerAutoload.player = self;


# func _unhandled_input(event):
# 	if !is_multiplayer_authority(): return;

# 	if event is InputEventMouseMotion:
# 		rotate_y(-event.relative.x * .005);
# 		camera.rotate_x(-event.relative.y * .005);
# 		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2);


func _physics_process(delta: float) -> void:
	# apply_central_force(Vector3.FORWARD*50);

	# return;
	# print("Looping movement.")
	# apply_gravity()
	# print(str(is_grounded()));

	# Calculate movement direction
	move_dir = Vector3()
	var input_vector = get_input_vector()
	# print("input is"+str(input_vector))

	# Move the player relative to the camera's orientation
	if input_vector != Vector3.ZERO:
		var camera_dir = -camera.global_transform.basis.z.normalized()
		var right_dir = camera.global_transform.basis.x.normalized()
		move_dir = (camera_dir * input_vector.z + right_dir * input_vector.x).normalized()

		# Apply force for movement
		var target_velocity = move_dir * speed
		var current_velocity = linear_velocity
		var velocity_change = target_velocity - current_velocity
		velocity_change.y = 0  # Keep the y axis untouched for gravity and jumping
		# apply_impulse(Vector3(), velocity_change)
		apply_central_force(velocity_change)
		# print("Velocity change is "+str(velocity_change))

	# Limit max speed to avoid infinite acceleration
	# if linear_velocity.length() > max_speed:
	# 	linear_velocity = linear_velocity.normalized() * max_speed

	# Jump handling
	if Input.is_action_just_pressed("jump") and is_grounded():
		# apply_impulse(Vector3(), Vector3(0, jump_strength, 0))
		linear_velocity = Vector3(linear_velocity.x, jump_strength, linear_velocity.z)
		# print("JUMP!")

	apply_gravity();

# Helper to apply gravity manually
func apply_gravity():
	if !is_grounded():
		apply_central_force(Vector3(0, gravity, 0))

# Process input direction
func get_input_vector() -> Vector3:
	if !is_multiplayer_authority(): return Vector3.ZERO;
	var input_vector = Vector3()

	if Input.is_action_pressed("move_forward"):
		input_vector.z += 1
	if Input.is_action_pressed("move_backward"):
		input_vector.z -= 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	return input_vector.normalized()

func is_grounded() -> bool:
	return true;
	# return groundedChecker.is_grounded();


# # Collision check for grounding (simple example)
# func _on_body_entered(body):
# 	if body.is_in_group("ground"):
# 		is_grounded = true

# func _on_body_exited(body):
# 	if body.is_in_group("ground"):
# 		is_grounded = false
