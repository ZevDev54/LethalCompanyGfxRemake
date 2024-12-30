extends Camera3D

# Sensitivity for mouse movement
var mouse_sensitivity = 0.1

# Maximum and minimum pitch angles to prevent flipping
var max_pitch = 90
var min_pitch = -90

# Rotation variables
var yaw = 0
var pitch = 0

# Camera reference (assign in the editor or find it in _ready)
@onready var camera = self  # Ensure you have a Camera3D node as a child

func _ready():
    # Capture the mouse cursor
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
    # Mouse motion handling
    if event is InputEventMouseMotion:
        _update_camera_rotation(event.relative)

# Update camera rotation based on mouse movement
func _update_camera_rotation(relative_motion):
    # Update yaw (rotation around the Y-axis)
    yaw -= relative_motion.x * mouse_sensitivity
    
    # Update pitch (rotation around the X-axis), but clamp it to prevent flipping
    pitch -= relative_motion.y * mouse_sensitivity
    pitch = clamp(pitch, min_pitch, max_pitch)
    
    # Apply rotation: yaw to the player (Node3D) and pitch to the camera
    rotation_degrees.y = yaw
    camera.rotation_degrees.x = pitch