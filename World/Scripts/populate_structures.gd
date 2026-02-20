class_name NavigationGenerator
extends TileMapLayer

const POPULATION_RADIUS: int = 4
const RADIUS_EXTENDER: int = 2
const TILES_PER_FRAME: int = 20

# Dictionary used as a fast hash set
var populated_chunks := {}   # key: Vector2i, value: true
var queued_cells: Array[Vector2i]

func _process(delta: float) -> void:
	for i in range(TILES_PER_FRAME):
		if queued_cells.is_empty(): return
		set_cell(queued_cells[0], 0, Vector2i(0,0))
		queued_cells.remove_at(0)

func populate_location(location: Vector2) -> void:
	var tile_pos: Vector2i = local_to_map(location)
	var player_chunk_pos: Vector2i = tile_pos / POPULATION_RADIUS
	
	var start_pos := player_chunk_pos - Vector2i(RADIUS_EXTENDER, RADIUS_EXTENDER)
	var end_range := RADIUS_EXTENDER * 2
	
	
	for x in range(end_range):
		for y in range(end_range):
			var chunk_position := start_pos + Vector2i(x, y)
			
			# O(1) lookup instead of O(n)
			if populated_chunks.has(chunk_position):
				continue
			
			populated_chunks[chunk_position] = true
			
			var tile_start := chunk_position * POPULATION_RADIUS
			
			for tile_x in range(POPULATION_RADIUS):
				for tile_y in range(POPULATION_RADIUS):
					var tile_position := tile_start + Vector2i(tile_x, tile_y)
					
					## If you KNOW these tiles are always empty,
					## you can remove this check for even more speed
					#if get_cell_source_id(tile_position) == -1:
					queued_cells.append(tile_position)
	
