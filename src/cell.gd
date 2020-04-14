extends Position2D

const TEXTURE_BLACK = preload("res://assets/textures/black_cube.png")
const TEXTURE_GREEN = preload("res://assets/textures/green_cube.png")

onready var spr_texture = get_node("spr_texture")
var status
var position_grid
var next_status

func _init():
	status = false

func _ready():
	update_texture()
	get_node("Label").set_text(str(position_grid))

func is_alive():
	return status

func set_alive(p_status):
	status = p_status 

func set_next_status(p_state):
	next_status = p_state

func update_texture():
	if status == false:
		spr_texture.set_texture(TEXTURE_BLACK)
	else:
		spr_texture.set_texture(TEXTURE_GREEN)

func set_position_grid(p_pos):
	position_grid = p_pos

func get_position_grid():
	return position_grid

func update():
	status = next_status
	update_texture()
