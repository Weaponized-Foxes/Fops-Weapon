extends TileMapLayer
var rng = RandomNumberGenerator.new()
var tarrains = [0,1]

func addTiles(StartAreaX: int,StartAreaY: int,EndAreaX: int,EndAreaY: int) -> Array:
	var tiles = []
	for TileY in range(StartAreaY,EndAreaY):
		for TileX in range(StartAreaX,EndAreaX):
			tiles.append(Vector2i(TileX,TileY))
	return tiles

func genAreaTiles(StartAreaX: int,StartAreaY: int,EndAreaX: int,EndAreaY: int) -> void:
	var TileArray = addTiles(StartAreaX,StartAreaY,EndAreaX,EndAreaY)
	set_cells_terrain_connect(TileArray, 0, tarrains.pick_random())
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	var size = 2
	var previousY = -2
	var previousX = -2
	for cubeY in range(-2,2):
		for cubeX in range(-2,2):
			genAreaTiles(previousX*size,previousY*size,cubeX*size+2,cubeY*size+2)
			previousX = cubeX
		previousY = cubeY
			
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
