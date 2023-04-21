@tool
extends NavigationRegion2D
class_name NavigationMap

const MAP_COLLISION_LAYER = 2
const PHYSIC_COLLISION_LAYER = 0
const MAP_OFFSET = Vector2(32., -6.)
const DIRECTIONS: Array = [
	Vector2i(1, 0),
	Vector2i(-1, 0),
	Vector2i(0, 1),
	Vector2i(0, -1),
	Vector2i(1, 1),
	Vector2i(-1, -1),
	Vector2i(1, -1),
	Vector2i(-1, 1)
]

@onready var map: TileMap = get_parent()

func _ready():
	map.changed.connect(_on_map_changed)
	_on_map_changed()

func _on_map_changed():
	navigation_polygon = get_collision_polygons()

func get_collision_polygons() -> NavigationPolygon:
	var polygon: NavigationPolygon = NavigationPolygon.new()
	
	var map_rect: Rect2i = map.get_used_rect()
	polygon.vertices = PackedVector2Array([
		map.map_to_local(map_rect.position) - map.cell_quadrant_size / 2 * Vector2.ONE,
		map.map_to_local(map_rect.position + map_rect.size.x * Vector2i(1, 0)) - map.cell_quadrant_size / 2 * Vector2.ONE,
		map.map_to_local(map_rect.end) - map.cell_quadrant_size / 2 * Vector2.ONE,
		map.map_to_local(map_rect.position + map_rect.size.y * Vector2i(0, 1)) - map.cell_quadrant_size / 2 * Vector2.ONE
	])
	polygon.add_polygon(range(4))
	
	var visited: Dictionary = {}
	for cell_coords in map.get_used_cells(MAP_COLLISION_LAYER):
		visited[cell_coords] = false
	
	for cell_coords in visited:
		if visited[cell_coords]:
			continue
		
		var adjacent_cells_coords: Array[Vector2i] = get_adjacent_cells_coords(cell_coords, visited)
		
		var new_vertices: PackedVector2Array = create_vertices(adjacent_cells_coords)
#		polygon.add_outline(new_vertices)

		polygon.vertices += new_vertices
		polygon.add_polygon(range(polygon.vertices.size() - new_vertices.size(), polygon.vertices.size()))
	
#	polygon.make_polygons_from_outlines()
	
	return polygon

func get_adjacent_cells_coords(cell_coords: Vector2i, visited: Dictionary) -> Array[Vector2i]:
	if visited.get(cell_coords, true):
		return []
	visited[cell_coords] = true
	
	var adjacent_cells_coords: Array[Vector2i] = [cell_coords]
	
	for adjacent_coords in map.get_surrounding_cells(cell_coords):
		adjacent_cells_coords.append_array(get_adjacent_cells_coords(adjacent_coords, visited))
	
	return adjacent_cells_coords

func create_vertices(cell_coords_list: Array[Vector2i]) -> PackedVector2Array:
	var vertices: PackedVector2Array = PackedVector2Array([])
	
	for cell_coords in cell_coords_list:
		var cell: TileData = map.get_cell_tile_data(MAP_COLLISION_LAYER, cell_coords)
		for polygon_index in cell.get_collision_polygons_count(PHYSIC_COLLISION_LAYER):
			for point in cell.get_collision_polygon_points(PHYSIC_COLLISION_LAYER, polygon_index):
				vertices.append(map.map_to_local(cell_coords) + point)
	
	return Geometry2D.convex_hull(vertices)
