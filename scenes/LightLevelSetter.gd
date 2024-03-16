extends Node3D

@export var lightMesh : GeometryInstance3D;
@export  var light : Light3D;

var lightLevelPercent := 1.0;
@export var lightLevelDegradation : float = 0.1;

var curve : Curve2D;

var startingLightEnergy;


# Called when the node enters the scene tree for the first time.
func _ready():
	startingLightEnergy = light.light_energy;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(lightLevelPercent > 0):
		lightLevelPercent -= delta * lightLevelDegradation;
		print("AAAA")
	else:
		lightLevelPercent = 0;

	# var emis =  lightMesh.surface_get_material.get_parameter(3);
	# var emission = Color(lightLevelPercent,lightLevelPercent,lightLevelPercent);
	# lightMesh.material(0).set_parameter(3, emission)

	light.light_energy = startingLightEnergy * lightLevelPercent;

	print(lightLevelPercent);
