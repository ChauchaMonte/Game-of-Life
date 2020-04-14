extends Node2D

const CELL = preload("res://scenes/cell.tscn")
const OFFSET = 60
const POSITION_START = Vector2(30,30)
const MAX_WIDTH = 10
const MAX_HEIGHT = 10

onready var timer = get_node("Timer")

var grid

func _init():
	grid = []

func _ready():
	timer.connect("timeout", self, "update", [], 0)

func set_up():
	create_grid()
	load_grid()
	timer.start()

func update():
	calculate_next_grid()
	for element in grid:
		for cell in element:
			cell.update()

func create_grid():
	var aux_cell
	for width_pos in range(MAX_WIDTH):
		var aux_arr = []
		for height_pos in range(MAX_HEIGHT):
			aux_cell = CELL.instance()
			aux_cell.set_position(POSITION_START + (OFFSET * Vector2(width_pos, height_pos)))
			aux_cell.set_position_grid(Vector2(width_pos, height_pos))
			add_child(aux_cell)
			aux_arr.push_back(aux_cell)
		grid.push_back(aux_arr)

func get_status_cells(p_pos_cell):
	return grid[p_pos_cell.x][p_pos_cell.y].is_alive()

func get_quantity_neighbors_alive(p_position):
	var count = 0
	# Check cell on the right.
	if (p_position.x != 0 and get_status_cells(Vector2(p_position.x -1, p_position.y))):
		count += 1
	
	# Check cell on the bottom right.
	if (p_position.x != 0 and p_position.y < MAX_HEIGHT - 1
		and get_status_cells(Vector2(p_position.x - 1, p_position.y + 1))):
		count += 1
	
	# Check cell on the bottom.
	if (p_position.y < MAX_HEIGHT - 1 and get_status_cells(Vector2(p_position.x, p_position.y + 1))):
		count += 1
	
	# Check cell on the bottom left.
	if (p_position.x < MAX_WIDTH - 1 and p_position.y < MAX_HEIGHT - 1
		and get_status_cells(Vector2(p_position.x + 1, p_position.y + 1))):
		count += 1
	
	# Check cell on the left.
	if (p_position.x < MAX_WIDTH - 1 and get_status_cells(Vector2(p_position.x + 1, p_position.y))):
		count += 1
		
	# Check cell on the top left.
	if (p_position.x < MAX_WIDTH - 1 and p_position.y != 0 
		and get_status_cells(Vector2(p_position.x + 1, p_position.y - 1))):
		count += 1
	
	# Check cell on the top.
	if (p_position.y != 0 and get_status_cells(Vector2(p_position.x, p_position.y - 1))):
		count += 1
	
	# Check cell on the top right.
	if (p_position.x != 0 and p_position.y != 0 
		and get_status_cells(Vector2(p_position.x - 1, p_position.y - 1))):
		count += 1
	
	return count

func calculate_next_grid():
	var is_alive
	var count_neighbors
	var result
	
	for element in grid:
		for cell in element:
			is_alive = cell.is_alive()
			count_neighbors = get_quantity_neighbors_alive(cell.get_position_grid())
			result = false
			
			if is_alive and count_neighbors < 2:
				result = false
			if is_alive and (count_neighbors == 2 or count_neighbors == 3):
				result = true
			if is_alive and count_neighbors > 3:
				result = false
			if not is_alive and count_neighbors == 3:
				result = true
			
			cell.set_next_status(result)

func load_grid():
	grid[4][4].set_alive(true)
	grid[5][4].set_alive(true)
	grid[5][5].set_alive(true)
	grid[6][5].set_alive(true)
	grid[5][6].set_alive(true)
	grid[4][4].update_texture()
	grid[5][4].update_texture()
	grid[5][6].update_texture()
	grid[6][5].update_texture()
	grid[5][5].update_texture()

#func load_grid():
#	grid[1][2].set_alive(true)
#	grid[2][3].set_alive(true)
#	grid[0][4].set_alive(true)
#	grid[1][4].set_alive(true)
#	grid[2][4].set_alive(true)
#	grid[1][2].update_texture()
#	grid[2][3].update_texture()
#	grid[0][4].update_texture()
#	grid[1][4].update_texture()
#	grid[2][4].update_texture()
