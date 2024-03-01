extends Node2D
var widthInBricksPerLayer = 1
var heightInBricksPerTower = 2

var currentTowerWidthInBricks = 0
var currentTowerLayerHeight = 0
var currentTower = 0
var currentTowerAngle = 0



@export var radius = 100

@onready var brickPixelWidth = $StoneBrick.texture.get_width()
@onready var brickPixelHeight = $StoneBrick.texture.get_height()
@onready var brickStartingScale = $StoneBrick.scale
@onready var brickStartingAngle = rad_to_deg($StoneBrick.rotation)
@onready var currentScale = brickStartingScale


func _ready():
	Events.addBrick.connect(addBrick)
	$Area2D/CollisionShape2D.shape.radius = radius




func addBrick():
	var newBrick = $StoneBrick.duplicate()
	var brickAngle = getLayerAngle()
	var layerCenterPoint = getCenterOfLayerOnCircle()
	var layerPixelWidth = float(widthInBricksPerLayer * brickPixelWidth * currentScale.x)
	var positionInLayer = float(currentTowerWidthInBricks) / float(widthInBricksPerLayer)
	print("positionInLayer offset ", positionInLayer , " ", currentTowerWidthInBricks , " ", widthInBricksPerLayer, " ", (layerPixelWidth * positionInLayer) )
	print(brickAngle)
	newBrick.position.x  = layerCenterPoint.x + (layerPixelWidth * positionInLayer) 
	newBrick.position.y = layerCenterPoint.y + (currentTowerLayerHeight * brickPixelHeight * currentScale.y) * -1
	newBrick.rotation = deg_to_rad(brickAngle + brickStartingAngle)
	print("rotation set at ", newBrick.rotation)

	newBrick.visible = true
	$'.'.add_child(newBrick)
	currentTowerWidthInBricks += 1
	# if the layer is finished currentScale.x
	if currentTowerWidthInBricks == widthInBricksPerLayer:
		#print("increasing tower height")
		currentTowerWidthInBricks = 0
		currentTowerLayerHeight += 1
		Events.addTowerHeight.emit(1)
		if currentTowerLayerHeight == heightInBricksPerTower:
			#print("increasing current tower")
			currentTowerLayerHeight = 0
			currentTower += 1



func getLayerAngle():
	var angle = (currentTower * 30) % 360
	print("angle is: ", angle)
	#return ((currentTower * 20) + 90) % 360
	return angle


func getCenterOfLayerOnCircle():
	var centerOfLayerOnCircle = Vector2()
	#for t in currentTower:
		#centerOfLayerOnCircle.x = cos(radius)
		#centerOfLayerOnCircle.y = -sin(radius)
		#currentTowerAngle = centerOfLayerOnCircle
	var angle = getLayerAngle()
	centerOfLayerOnCircle.x = cos(deg_to_rad(angle)) * radius
	centerOfLayerOnCircle.y = sin(deg_to_rad(angle)) * radius
	print("getCenterOfLayerOnCircle: ", centerOfLayerOnCircle)
	return centerOfLayerOnCircle



func getBrickPosition():
	pass



