@tool

extends Node3D


@export var target_parent : Node3D;
@export var instanceScene : PackedScene;

@export var minSpawningBoxSize := Vector3.ONE;
@export var maxSpawningBoxSize := Vector3.ONE;
var spawningBoxSize : Vector3;

@export var minSpawnAmount := 5;
@export var maxSpawnAmount := 10;


@export var activateButton := false;
@export var clearButton := false;



func _ready():
	spawningBoxSize = Vector3(
		randf_range(minSpawningBoxSize.x, maxSpawningBoxSize.x),
		randf_range(minSpawningBoxSize.y, maxSpawningBoxSize.y),
		randf_range(minSpawningBoxSize.z, maxSpawningBoxSize.z),
	)
	activate();


func _process(delta):

	if Input.is_action_pressed("lantern"):
		clear();
		activate();

	if(activateButton):
		activateButton = false;
		clear();
		activate();
	if(clearButton):
		clearButton = false;
		clear();

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:

func clear():
	for child in target_parent.get_children():
		child.queue_free();

func activate():
	var box_amount = randf_range(minSpawnAmount, maxSpawnAmount);
	for i in range(box_amount):
		# Instantiate a new CSGBox
		# var csg_box = CSGBox3D.new()
		var spawned = instanceScene.instantiate() as CSGBox3D;



		target_parent.add_child(spawned)
		# Set position
		spawned.position = Vector3(
			randf_range(spawningBoxSize.x * -0.5, spawningBoxSize.x * 0.5),
			randf_range(spawningBoxSize.y * -0.5, spawningBoxSize.y * 0.5) + 0.4*( spawned.size.y if spawned is CSGBox3D else spawned.scale.y),
			randf_range(spawningBoxSize.z * -0.5, spawningBoxSize.z * 0.5)
		) 

		# if(spawned is )

		# # Set position
		# csg_shape.global_position = Vector3(
		# 	original_position.x + randf_range(original_size.x * -0.1, original_size.x * 0.1),
		# 	original_position.y + randf_range(original_size.y * -0.1, original_size.y * 0.1),
		# 	original_position.z + randf_range(original_size.z * -0.1, original_size.z * 0.1)
		# ) 

		# csg_shape.size = Vector3(
		# 	randf_range(operation.operator_min_size.x, operation.operator_max_size.x), 
		# 	randf_range(operation.operator_min_size.y, operation.operator_max_size.y),
		# 	randf_range(operation.operator_min_size.z, operation.operator_max_size.z)
		# 	) # Set box size (width, height, depth)

		# csg_shape.operation = operation.operation_type;

		# Add the CSGBox to the current scene
		# target_csg.add_child(csg_box)
