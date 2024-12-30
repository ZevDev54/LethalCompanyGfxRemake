extends Resource
class_name CsgOperatorGroup

@export var spawn : PackedScene;
@export var operator_count_min := 5;
@export var operator_count_max := 10;

@export var operator_min_size := Vector3(5,5,5);
@export var operator_max_size := Vector3(10,10,10);

@export var operation_type : CSGBox3D.Operation;
