extends Node2D

const N = 0x1
const E = 0x2
const S = 0x4
const W = 0x8

var cell_walls = {Vector2(0, -1): N, Vector2(1, 0): E,
				  Vector2(0, 1): S, Vector2(-1, 0): W}

onready var Map = $TileMap

func _ready():
	$Truck.map = Map
	$Truck.map_pos = Vector2(0, 0)
	$Truck.position = Map.map_to_world($Truck.map_pos) + Vector2(0, 20)
	
func generate_tile(cell):
	var cells = find_valid_tiles(cell)
	Map.set_cellv(cell, cells[randi() % cells.size()])
	
func find_valid_tiles(cell):
	var valid_tiles = []
	# returns all valid tiles for a given cell
	for i in range(16):
		# check target space's neighbors (if they exist)
		var is_match = false
		for n in cell_walls.keys():
			var neighbor_id = Map.get_cellv(cell + n)
			if neighbor_id >= 0:
				if (neighbor_id & cell_walls[-n])/cell_walls[-n] == (i & cell_walls[n])/cell_walls[n]:
					is_match = true
				else:
					is_match = false
					break
		if is_match and not i in valid_tiles:
			valid_tiles.append(i)
	return valid_tiles
				
				 