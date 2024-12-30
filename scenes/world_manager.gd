extends Node

@export var worlds : Array[PackedScene];
@export var whichWorldInt := 0;
var actualWorld : Node3D;

@export var players : Array[PackedScene];
@export var whichPlayerInt := 0;

@export var networkManager : NetworkManager


func _ready() -> void:
	actualWorld = worlds[whichWorldInt].instantiate() as Node3D;
	self.add_child(actualWorld);
	networkManager.playerSpawnParent = actualWorld;

	networkManager.player_scene = players[whichPlayerInt];
