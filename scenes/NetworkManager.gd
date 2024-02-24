extends Node

@export var menu_ui : Control;
@export var address_entry : LineEdit;

@export var player_scene : PackedScene;

@export var playerSpawnParent : Node3D;

@export var port = 7777;
var enet_peer = ENetMultiplayerPeer.new();

func _on_join_button_pressed():
	menu_ui.hide()

	enet_peer.create_client(address_entry.text, port)
	multiplayer.multiplayer_peer = enet_peer;

func _on_host_button_pressed():
	menu_ui.hide()

	enet_peer.create_server(port)
	multiplayer.multiplayer_peer = enet_peer;
	multiplayer.peer_connected.connect(add_player)

	add_player(multiplayer.get_unique_id())

func add_player(peer_id):
	var player = player_scene.instantiate();
	player.name = str(peer_id);
	playerSpawnParent.add_child(player);

	print("added player"+str(peer_id));
