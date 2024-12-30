@tool
# extends Node;
extends Node

@export var target_parent : Node3D;
@export var operationBatches : Array[CsgOperatorGroup];


@export var activateButton := false;
@export var clearButton := false;

func _ready():
	activate();


func _process(delta):
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
	var original_size := Vector3.ONE;

	if(target_parent is CSGBox3D):
		target_parent.size  = target_parent.size * randf_range(0.5, 2);
		original_size = target_parent.size;
	else:
		original_size = target_parent.scale;

	var original_position : Vector3 = target_parent.global_position;
	for operation in operationBatches:

		var actual_box_amount = randf_range(operation.operator_count_min, operation.operator_count_max );
		for i in range(actual_box_amount):
			# Instantiate a new CSGBox
			# var csg_box = CSGBox3D.new()
			var csg_shape = operation.spawn.instantiate() as CSGBox3D;



			target_parent.add_child(csg_shape)
			# Set position
			csg_shape.position = Vector3(
				randf_range(original_size.x * -0.5, original_size.x * 0.5),
				randf_range(original_size.y * -0.5, original_size.y * 0.5),
				randf_range(original_size.z * -0.5, original_size.z * 0.5)
			) 


			# # Set position
			# csg_shape.global_position = Vector3(
			# 	original_position.x + randf_range(original_size.x * -0.1, original_size.x * 0.1),
			# 	original_position.y + randf_range(original_size.y * -0.1, original_size.y * 0.1),
			# 	original_position.z + randf_range(original_size.z * -0.1, original_size.z * 0.1)
			# ) 

			csg_shape.size = Vector3(
				randf_range(operation.operator_min_size.x, operation.operator_max_size.x), 
				randf_range(operation.operator_min_size.y, operation.operator_max_size.y),
				randf_range(operation.operator_min_size.z, operation.operator_max_size.z)
				) # Set box size (width, height, depth)

			csg_shape.operation = operation.operation_type;

			# Add the CSGBox to the current scene
			# target_csg.add_child(csg_box)
