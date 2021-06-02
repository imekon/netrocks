extends KinematicBody2D

const BASE_THRUST = 20
const RANGE_THRUST = 50

var thrust
var velocity

func _ready():
	thrust = randi() % RANGE_THRUST + BASE_THRUST
	var angle = randi() % 360
	rotation_degrees = angle
	velocity = Vector2(thrust, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision != null:
		velocity = velocity.bounce(collision.normal)

	if position.x < 0: position.x = 1024
	if position.x > 1024: position.x = 0
	if position.y < 0: position.y = 600
	if position.y > 600: position.y = 0
