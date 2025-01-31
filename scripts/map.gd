extends TileMapLayer
var rng = RandomNumberGenerator.new()
var pathPositions: Dictionary

func getPathPattern(Type: String):
	match Type:
		"left-right":
			return [tile_set.get_pattern(0),tile_set.get_pattern(1)]
		"right-left":
			return [tile_set.get_pattern(0),tile_set.get_pattern(1)]
		"up-down":
			return [tile_set.get_pattern(2),tile_set.get_pattern(3)]
		"down-up":
			return [tile_set.get_pattern(2),tile_set.get_pattern(3)]
		
		"up-right":
			return [tile_set.get_pattern(4),tile_set.get_pattern(5)]
		"right-up":
			return [tile_set.get_pattern(4),tile_set.get_pattern(5)]
		
		"up-left":
			return [tile_set.get_pattern(6),tile_set.get_pattern(7)]
		"left-up":
			return [tile_set.get_pattern(6),tile_set.get_pattern(7)]

		"down-right":
			return [tile_set.get_pattern(8),tile_set.get_pattern(9)]
		"right-down":
			return [tile_set.get_pattern(8),tile_set.get_pattern(9)]
		
		"down-left":
			return [tile_set.get_pattern(10),tile_set.get_pattern(11)]
		"left-down":
			return [tile_set.get_pattern(10),tile_set.get_pattern(11)]

func getPathOptions(move: String):
	match move:
		"right":
			return ["down-left","up-left","right-left"]
		"left":
			return ["up-right","down-right","left-right"]
		"up":
			return ["down-right","down-left","down-up"]
		"down":
			return ["up-right","up-left","up-down"]

func genPattern(pos,pattern: int, comeFrom: String, depth: int) -> void:
	if depth > 5:
		return
	set_pattern(pos,tile_set.get_pattern(pattern))
	get_child(0).set_pattern(pos,tile_set.get_pattern(pattern + 1))
	for direction in pathPositions[pattern].keys():
		if direction == comeFrom:
			continue
		var nextDir = nextDirection(direction)
		var patterns = []
		for pat in pathPositions.keys():
			if pathPositions[pat].has(nextDir):
				patterns.append(pat)
		if patterns.size() == 0:
			continue
		var chosenPattern = patterns[rng.randi_range(0, patterns.size() - 1)]
		genPattern(calcPos(pattern, chosenPattern, direction, pos), chosenPattern, nextDir, depth + 1)


func calcPos(pattern1, pattern2, dir_from, pos) -> Vector2i:
	match dir_from:
		"left":
			pos.x -= tile_set.get_pattern(pattern2).get_size().x
			pos.y += pathPositions[pattern1][dir_from].y - pathPositions[pattern2][nextDirection(dir_from)].y
		"right":
			pos.x += tile_set.get_pattern(pattern1).get_size().x
			pos.y += pathPositions[pattern1][dir_from].y - pathPositions[pattern2][nextDirection(dir_from)].y
		"up":
			pos.y += tile_set.get_pattern(pattern2).get_size().y
			pos.x += pathPositions[pattern1][dir_from].x - pathPositions[pattern2][nextDirection(dir_from)].x
		"down":
			pos.y -= tile_set.get_pattern(pattern2).get_size().y
			pos.x += pathPositions[pattern1][dir_from].x - pathPositions[pattern2][nextDirection(dir_from)].x
	return pos
		

func pathGen():
	genPattern(Vector2i(0,-7), 0, "", 0)

func nextDirection(direction: String):
	match direction:
		"right":
			return "left"
		"left":
			return "right"
		"up":
			return "down"
		"down":
			return "up"
		

func setupGenerator():
	var tiles = [0,2,4,6,8,10]
	pathPositions = {}
	for tile in tiles:
		pathPositions[tile] = {}
		var pattern = tile_set.get_pattern(tile)
		var size = pattern.get_size()
		for i in range(size.y):
			if pattern.get_cell_atlas_coords(Vector2i(0, i)) == Vector2i(7,0) || pattern.get_cell_atlas_coords(Vector2i(0, i)) == Vector2i(7,2):
				pathPositions[tile]["left"] = Vector2i(0,i)
			if pattern.get_cell_atlas_coords(Vector2i(size.x - 1, i)) == Vector2i(7,0) || pattern.get_cell_atlas_coords(Vector2i(size.x - 1, i)) == Vector2i(7,2):
				pathPositions[tile]["right"] = Vector2i(size.x - 1,i)
		for i in range(size.x):
			if pattern.get_cell_atlas_coords(Vector2i(i, 0)) == Vector2i(6,1) || pattern.get_cell_atlas_coords(Vector2i(i, 0)) == Vector2i(8,1):
				pathPositions[tile]["down"] = Vector2i(i,0)
			if pattern.get_cell_atlas_coords(Vector2i(i, size.y - 1)) == Vector2i(6, 1) || pattern.get_cell_atlas_coords(Vector2i(i, size.y - 1)) == Vector2i(8, 1):
				pathPositions[tile]["up"] = Vector2i(i,size.y - 1)

func _ready() -> void:
	setupGenerator()
	pathGen()
