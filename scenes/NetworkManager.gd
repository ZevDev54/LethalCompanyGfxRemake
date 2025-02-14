class_name NetworkManager
extends Node

@export var menu_ui : Control;
@export var address_entry : LineEdit;

@export var player_scene : PackedScene;

@export var playerSpawnParent : Node3D;

@export var port = 7777;
var enet_peer = ENetMultiplayerPeer.new();

@export var multiplayerSpawner : MultiplayerSpawner;

func _ready():
	multiplayerSpawner.spawn_path = playerSpawnParent.get_path();

func _on_join_button_pressed():
	print("join button pressed");
	menu_ui.hide()

	enet_peer.create_client(address_entry.text, port)
	multiplayer.multiplayer_peer = enet_peer;
	multiplayer.peer_connected.connect(add_player)
	

func _on_host_button_pressed():
	print("host button pressed");
	menu_ui.hide()

	enet_peer.create_server(port)
	
	multiplayer.multiplayer_peer = enet_peer;
	multiplayer.peer_connected.connect(add_player)

	add_player(multiplayer.get_unique_id())

func add_player(peer_id):
	var player = player_scene.instantiate();
	player.name = str(peer_id);
	# player.set_multiplayer_authority(peer_id) #second param true
	playerSpawnParent.add_child(player);

	if(!multiplayer.is_server()):
		print("spawning a player on client! "+str(peer_id));
	# else:
		# multiplayerSpawner.spawn(player);


	print("added player"+str(peer_id));
