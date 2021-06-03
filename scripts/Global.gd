extends Node

const MAX_CLIENTS = 4

var networkPeer = NetworkedMultiplayerENet.new()
var peers = []
var levelScene = preload("res://scenes/Main.tscn")
var playerScene = preload("res://scenes/Player.tscn")

var levelInstance

signal levelLoaded

func _ready():
	networkPeer.connect("peer_connected", self, "peer_connected")
	networkPeer.connect("peer_disconnected", self, "peer_disconnected")
	get_tree().connect("connected_to_server", self, "connected_to_server")
	networkPeer.connect("server_disconnected", self, "server_disconnected")
	get_tree().connect("connection_failed", self, "connection_failed")

func create_server(port):
	connect("levelLoaded", self, "server_setup_after_load")
	get_tree().change_scene_to(levelScene)
	networkPeer.create_server(port, MAX_CLIENTS)
	
func server_setup_after_load():
	levelInstance = get_tree().current_scene
	get_tree().network_peer = networkPeer
	peers.append(1)
	create_player(1)

func create_client(address, port):
	connect("levelLoaded", self, "client_setup_after_load")
	get_tree().change_scene_to(levelScene)
	networkPeer.create_client(address, port)

func client_setup_after_load():
	levelInstance = get_tree().current_scene
	get_tree().network_peer = networkPeer

func peer_connected(peerId):
	peers.append(peerId)
	create_player(peerId)

func peer_disconnected(peerId):
	peers.remove(peers.find(peerId))
	destroy_player(peerId)

func connected_to_server():
	create_player(get_tree().get_network_unique_id())

func connection_failed():
	server_disconnected()

func server_disconnected():
	peers.clear()
	get_tree().change_scene("res://Menu.tscn")
	
func create_player(peerId):
	var x = randi() % 1024
	var y = randi() % 600
	var player = playerScene.instance()
	player.set_network_master(peerId)
	player.name = String(peerId)
	player.position = Vector2(x, y)
	# player.rotation_degrees = float(randi() % 360)
	levelInstance.add_child(player)
	return player

func destroy_player(peerId):
	levelInstance.remove_node(levelInstance.get_node(String(peerId)))
