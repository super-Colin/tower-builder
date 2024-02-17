extends Node2D


var widthInBricksPerLayer = Configs.widthInBricksPerLayer
var widthInBricks = 0
var totalHeight = Globals.totalHeight

var rowStartingOffset = "center"
var nextBrickOffset = "center"
@onready var brickWidth = $StoneBrick.texture.get_width()
@onready var brickHeight = $StoneBrick.texture.get_height()

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.addBrick.connect(addBrick)
	buildLayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func buildLayer():
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	addBrick()
	pass


func addBrick():
	var newBrick = $StoneBrick.duplicate()
	newBrick.visible = true
	newBrick.position.y = (brickHeight * totalHeight) * -1
	newBrick.position.x = brickWidth * widthInBricks
	if nextBrickOffset == "low":
		newBrick.position.y -= brickHeight / 2
		nextBrickOffset = "center"
	else:
		nextBrickOffset = "low"
	$'.'.add_child(newBrick)
	widthInBricks +=1
	# if the layer is finished
	if widthInBricks == widthInBricksPerLayer:
		widthInBricks = 0
		totalHeight += 1
		Events.addTowerHeight.emit(1)
		nextBrickOffset = rowStartingOffset






