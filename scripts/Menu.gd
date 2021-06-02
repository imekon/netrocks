extends PanelContainer

onready var host = $Panel/Host
onready var hostPort = $Panel/Host/Port
onready var join = $Panel/Join
onready var joinAddress = $Panel/Join/Address
onready var joinPort = $Panel/Join/Port

func host_pressed():
	var port = int(hostPort.text)
	Global.create_server(port)

func join_pressed():
	var address = joinAddress.text
	var port = int(joinPort.text)
	Global.create_client(address, port)
