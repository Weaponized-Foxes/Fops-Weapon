extends TileMapLayer
var rng = RandomNumberGenerator.new()
var tarrains = [0,1]

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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	var previousY = -10*8
	var previousX = -10*8
	var area = 10*8

	for cubeY in range(previousY,area,7):
		for cubeX in range(previousX,area,7):
			genAreaTiles(8,cubeX,cubeY)
	
	
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
