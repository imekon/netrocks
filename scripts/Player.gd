extends KinematicBody2D

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

remotesync func die():
	visible = false

remotesync func respawn():
	visible = true
