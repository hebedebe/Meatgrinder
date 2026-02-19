class_name NavigationGenerator
extends TileMapLayer

const POPULATION_RADIUS: int = 8;
const RADIUS_EXTENDER = 1;

var player: Player;
var populatedChunks: Array[Vector2i] = []

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player");
	
func populate_location(location: Vector2):
	var tile_pos = local_to_map(location)
	
	@warning_ignore("integer_division") 
	var player_chunk_pos = tile_pos / POPULATION_RADIUS
	
	var start_pos = player_chunk_pos - Vector2i(RADIUS_EXTENDER, RADIUS_EXTENDER)
	for x in range(RADIUS_EXTENDER*2):
		for y in range(RADIUS_EXTENDER*2):
			var chunk_position = start_pos + Vector2i(x, y)
			if not chunk_position in populatedChunks:
					populatedChunks.append(chunk_position)
					var tile_start_position = chunk_position * POPULATION_RADIUS;
					for tile_x in range(POPULATION_RADIUS):
						for tile_y in range(POPULATION_RADIUS):
							var tile_position = tile_start_position + Vector2i(tile_x, tile_y)
							if (get_cell_source_id(tile_position) == -1):
								set_cell(tile_position, 0, Vector2i(0,0)); # set to empty navigable cell
