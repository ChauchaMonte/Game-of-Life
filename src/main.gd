extends Node2D

onready var grid = get_node("grid")
onready var hud = get_node("hud")

func _ready():
	grid.set_up()

func update():
	pass
