extends Node

@export var authority_disable_list : Array[Node];
@export var authority_enable_list : Array[Node];


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	set_multiplayer_authority(str(get_parent().name).to_int())

	#var has_authority = is_multiplayer_authority();

	if is_multiplayer_authority():
		for enable in authority_enable_list:
			enable.show()
		
		for disable in authority_disable_list:
			disable.hide()
