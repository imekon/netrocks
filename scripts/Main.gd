extends Node2D

const num_of_rocks = 20

onready var rockScene = preload("res://scenes/Rock.tscn")
onready var playerScene = preload("res://scenes/Player.tscn")

func _ready():
	build_rocks()
	
	Global.emit_signal("levelLoaded")

func build_rocks():
	for _i in range(0, num_of_rocks):
		build_rock(rockScene)
		
func build_rock(rock_scene):
	var x = randi() % 1024
	var y = randi() % 600
	var rock = rock_scene.instance()
	rock.position = Vector2(x, y)
	add_child(rock)
	return rock
	
