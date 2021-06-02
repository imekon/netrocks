extends KinematicBody2D

var thrust

func _ready():
	thrust = randi() % 200 + 100
	var angle = randi() % 360
	rotation_degrees = angle

func _physics_process(delta):
	var velocity = Vector2(thrust, 0).rotated(rotation)
	move_and_slide(velocity)

	if position.x < 0: position.x = 1024
	if position.x > 1024: position.x = 0
	if position.y < 0: position.y = 600
	if position.y > 600: position.y = 0
