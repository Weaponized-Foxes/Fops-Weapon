extends TileMapLayer
var rng = RandomNumberGenerator.new()
var tarrains = [0,1]

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


func addChunk(size: int, centerX: int, centerY: int ) -> Array:
	var tiles = []
	var StartPosX = centerX - size/2
	var StartPosY = centerY - size/2
	for TileY in range(StartPosY,StartPosY+size):
		for TileX in range(StartPosX,StartPosX+size):
			tiles.append(Vector2i(TileX,TileY))
	return tiles

		
	

func addTiles(StartAreaX: int,StartAreaY: int,EndAreaX: int,EndAreaY: int) -> Array:
	var tiles = []
	for TileY in range(StartAreaY,EndAreaY):
		for TileX in range(StartAreaX,EndAreaX):
			tiles.append(Vector2i(TileX,TileY))
	return tiles

func genAreaTiles(size: int, CenterX: int, CenterY: int) -> void:
	var TileArray = addChunk(size,CenterX,CenterY)
	set_cells_terrain_connect(TileArray, 0, tarrains.pick_random())
	pass

func genPattern(CenterX,CenterY,Pattern: Array) -> void:
	set_pattern(Vector2i(CenterX,CenterY),Pattern[0])
	get_child(0).set_pattern(Vector2i(CenterX,CenterY),Pattern[1])


func randomGen():
	var previousY = -10*8
	var previousX = -10*8
	var area = 10*8

	for cubeY in range(previousY,area,7):
		for cubeX in range(previousX,area,7):
			rng.randomize() 
			genAreaTiles(8,cubeX,cubeY)
	
func HorizontalRight(pattern: TileMapPattern):
	var size = pattern.get_size()
	var cells = pattern.get_used_cells()
	var shift = 0
	for i in range(0,size.x):
		if pattern.get_cell_atlas_coords(Vector2i(14,i)) == Vector2i(7,0) or pattern.get_cell_atlas_coords(Vector2i(14,i)) == Vector2i(7,2):
			print(i)
			shift += i
			break
		if pattern.get_cell_atlas_coords(Vector2i(0,i)) ==  Vector2i(7,0) or pattern.get_cell_atlas_coords(Vector2i(0,i)) == Vector2i(7,2):
			print(i)
			shift += i
			break
	return shift

	


func pathGen():
	var Lx = -8
	var Ly = -8
	var Rx = -8
	var Ry = -8
	var Lmove = "left"
	var Rmove = "right"
	var Lpattern = getPathPattern("left-right")
	genPattern(Lx,Ly,Lpattern)
	
	var choice = getPathOptions(Lmove).pick_random()
	Lpattern = getPathPattern(choice)







	



	



	
	
	

	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#randomGen()
	pathGen()

	
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
