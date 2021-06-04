extends KinematicBody2D

const MOVEMENT = 3

func _ready():
	rset_config("rotation", MultiplayerAPI.RPC_MODE_PUPPET)
	rset_config("position", MultiplayerAPI.RPC_MODE_PUPPET)
	rset_config("visible", MultiplayerAPI.RPC_MODE_PUPPET)
	
	if(is_network_master()):
		set_process_input(true)
	else:
		set_process_input(false)
		
func _physics_process(delta):
	if(is_network_master()):
		_synchronize()
		
func _synchronize():
	rset("position", position)
	rset("rotation", rotation)
	rset("visible", visible)

func _input(event):
	var x = 0
	var y = 0
	if event.is_action("ui_left"):
		x -= MOVEMENT
	if event.is_action("ui_right"):
		x += MOVEMENT
	if event.is_action("ui_up"):
		y -= MOVEMENT
	if event.is_action("ui_down"):
		y += MOVEMENT
		
	position.x += x
	position.y += y
	
	if position.x < 0: position.x = 1024
	if position.x > 1024: position.x = 0
	if position.y < 0: position.y = 600
	if position.y > 600: position.y = 0

remotesync func die():
	visible = false

remotesync func respawn():
	visible = true
