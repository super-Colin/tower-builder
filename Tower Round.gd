extends Node2D
var widthInBricksPerLayer = 2
var heightInBricksPerTower = 2

var currentTowerWidthInBricks = 0
var currentTowerLayerHeight = 0
var currentTower = 0
var currentTowerAngle = 0



@export var radius = 100

@onready var brickPixelWidth = $StoneBrick.texture.get_width()
@onready var brickPixelHeight = $StoneBrick.texture.get_height()
@onready var brickStartingScale = $StoneBrick.scale
@onready var currentScale = brickStartingScale


func _ready():
	Events.addBrick.connect(addBrick)



func _process(delta):
	pass



func addBrick():
	var newBrick = $StoneBrick.duplicate()
	var brickAngle = getLayerAngle()
	var layerCenterPoint = getCenterOfLayerOnCircle()
	var layerPixelWidth = widthInBricksPerLayer * brickPixelWidth
	var positionInLayer = currentTowerWidthInBricks / widthInBricksPerLayer
	print("positionInLayer offset ", positionInLayer , " ", currentTowerWidthInBricks , " ", widthInBricksPerLayer)
	newBrick.visible = true
	#newBrick.position.x  = layerCenterPoint.x - (layerPixelWidth/2) + (brickPixelWidth * positionInLayer * currentScale.x)
	newBrick.position.x  = layerCenterPoint.x + (brickPixelWidth * currentTowerWidthInBricks * currentScale.x)
	newBrick.position.y = layerCenterPoint.y + (currentTowerLayerHeight * brickPixelHeight * currentScale.y) * -1
	#newBrick.position.y =  -100
	$'.'.add_child(newBrick)
	currentTowerWidthInBricks += 1
	# if the layer is finished currentScale.x
	if currentTowerWidthInBricks == widthInBricksPerLayer:
		#print("increasing tower height")
		currentTowerWidthInBricks = 0
		currentTowerLayerHeight += 1
		Events.addTowerHeight.emit(1)
		if currentTowerLayerHeight == heightInBricksPerTower:
			print("increasing current tower")
			currentTowerLayerHeight = 0
			currentTower += 1



func getLayerAngle():
	if currentTower == 0:
		return 0
	#print("angle is: ", currentTower * 20)
	return currentTower * 20


func getCenterOfLayerOnCircle():
	var centerOfLayerOnCircle = Vector2()
	#for t in currentTower:
		#centerOfLayerOnCircle.x = cos(radius)
		#centerOfLayerOnCircle.y = -sin(radius)
		#currentTowerAngle = centerOfLayerOnCircle
	var angle = getLayerAngle()
	centerOfLayerOnCircle.x = cos(angle) * radius
	centerOfLayerOnCircle.y = -sin(angle) * radius
	print("getCenterOfLayerOnCircle: ", centerOfLayerOnCircle) 
	return centerOfLayerOnCircle 
		


func getBrickPosition():
	pass



