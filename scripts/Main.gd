extends Node2D

onready var rockScene = preload("res://scenes/Rock.tscn")
onready var playerScene = preload("res://scenes/Player.tscn")

func _ready():
	build_rocks()

func build_rocks():
	for _i in range(0, 5):
		build_rock(rockScene)
		
	build_player()
		
func build_player():
	var x = randi() % 1024
	var y = randi() % 600
	var player = playerScene.instance()
	player.position = Vector2(x, y)
	add_child(player)
	return player
	
func build_rock(rock_scene):
	var x = randi() % 1024
	var y = randi() % 600
	var rock = rock_scene.instance()
	rock.position = Vector2(x, y)
	add_child(rock)
	return rock
	
