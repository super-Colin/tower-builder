extends Node2D
var widthInBricksPerLayer = 3
var heightInBricksPerTower = 2

var currentTowerWidthInBricks = 0
var currentTowerLayerHeight = 0
var currentTower = 0
var currentTowerAngle = 0



@export var radius = 100
@export var scaleFactor = 1

@onready var brickPixelWidth = $StoneBrick.texture.get_width()
@onready var brickPixelHeight = $StoneBrick.texture.get_height()
@onready var brickStartingScale = $StoneBrick.scale
@onready var brickStartingAngle = rad_to_deg($StoneBrick.rotation) 
@onready var currentScale = brickStartingScale


func _ready():
	Events.addBrick.connect(addBrick)
	$Area2D/CollisionShape2D.shape.radius = radius
	#$StoneBrick.visible = false



func addBrick():
	var newBrick = $StoneBrick.duplicate()
	var layerAngle = getLayerAngle()
	var towerCenterPointOnCircle = getCenterOfTowerOnCircle()
	var layerPixelWidth = float(widthInBricksPerLayer * brickPixelWidth * currentScale.x)
	var positionInLayer = float(currentTowerWidthInBricks) / float(widthInBricksPerLayer)
	#newBrick.position.x  = towerCenterPointOnCircle.x + (layerPixelWidth * positionInLayer) 
	#newBrick.position.y = towerCenterPointOnCircle.y + (currentTowerLayerHeight * brickPixelHeight * currentScale.y) * -1
	var nextPosition = Vector2(towerCenterPointOnCircle.x + (layerPixelWidth * positionInLayer),  towerCenterPointOnCircle.y + (currentTowerLayerHeight * brickPixelHeight * currentScale.y) * -1)
	#newBrick.position = setVectorLength(nextPosition, brickPixelHeight)
	var towerCenterPointOnLayer = setVectorLength(towerCenterPointOnCircle, brickPixelHeight * currentScale.y *currentTowerLayerHeight)
	#newBrick.position = setVectorLength(towerCenterPointOnCircle, brickPixelHeight * currentScale.x *currentTowerLayerHeight)
	newBrick.scale = currentScale
	newBrick.rotation = deg_to_rad(layerAngle + brickStartingAngle)
	newBrick.position = findBrickPointInLayer(towerCenterPointOnLayer)
	#print("rotation set at ", newBrick.rotation)

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
			incrementTowerCount()







func findBrickPointInLayer(layerCenterPointVector):
	if widthInBricksPerLayer <= 1:
		print("tower is only 1 wide.. ",layerCenterPointVector)
		print("=======")
		return layerCenterPointVector
	# find the brick that will be in the middle
	var midBrickPosition = ceil(widthInBricksPerLayer / 2.0)
	var isCenterOfOddLayer = currentTowerWidthInBricks + 1 == midBrickPosition and widthInBricksPerLayer % 2 != 0
	# build a new vector position
	var n = layerCenterPointVector
	var brickWidthFromCenter = ceil(widthInBricksPerLayer / 2 * brickPixelWidth) * currentScale.x
	var offsetVector = setVectorLength(layerCenterPointVector.orthogonal(), brickWidthFromCenter)
	#print("angle is ",layerCenterPointVector.angle())
	#print("orth vector is ",layerCenterPointVector.orthogonal())
	#print("midBrickPosition ", midBrickPosition, ", next width ", currentTowerWidthInBricks +1)
	# if less than the middle block
	if currentTowerWidthInBricks +1 < midBrickPosition:
		print("left side")
		offsetVector = setVectorLength(layerCenterPointVector.orthogonal(), brickWidthFromCenter)
	# if it's the middle of an odd row then return the center position
	if isCenterOfOddLayer:
		print("center")
		print("=======")
		return layerCenterPointVector
	if currentTowerWidthInBricks +1 > midBrickPosition :
		print("right side")
		offsetVector = setVectorLength(layerCenterPointVector.orthogonal(), brickWidthFromCenter) * -1

	print("offsetVector is ", offsetVector)
	print("final is ", layerCenterPointVector + offsetVector)
	print("=======")
	return layerCenterPointVector + offsetVector


#func findBrickPointInLayer(layerCenterPointVector):
	#var midBrickPosition = ceil(widthInBricksPerLayer / 2)
	#var isCenterOfOddLayer = currentTowerWidthInBricks + 1 == midBrickPosition and widthInBricksPerLayer % 2 != 0
	#if widthInBricksPerLayer <= 1 or isCenterOfOddLayer:
		#print("returning next position is center of odd row ",layerCenterPointVector)
		#print("=======")
		#return layerCenterPointVector
	#var n = Vector2()
	#var brickWidthFromCenter = ceil(widthInBricksPerLayer / 2 * brickPixelWidth) * currentScale.x
	#n += layerCenterPointVector
	#var offsetVector = setVectorLength(layerCenterPointVector.orthogonal(), brickWidthFromCenter)
	#print("angle is ",layerCenterPointVector.angle())
	#print("orth vector is ",layerCenterPointVector.orthogonal())
	#print("offsetVector is ", offsetVector)
	#
	#if currentTowerWidthInBricks +1 > midBrickPosition:
		#print("flipping -- ", currentTowerWidthInBricks, " currentTowerWidthInBricks-midBrickPosition ", midBrickPosition)
		#offsetVector = setVectorLength(layerCenterPointVector.orthogonal(), -brickWidthFromCenter)
	#
	#
	#var combinedV = offsetVector + layerCenterPointVector
	##var combinedV = Vector2()
	##combinedV.x = offsetVector.x + layerCenterPointVector.x
	##combinedV.y = offsetVector.y + layerCenterPointVector.y
	#print("combinedV is ", combinedV, " angle is ", combinedV.angle(), " --- new is ", n)
	#
	#
	
	

	#n.x = cos(layerCenterPointVector.angle() + combinedV.angle() ) * brickWidthFromCenter
	#n.y = sin(layerCenterPointVector.angle() + combinedV.angle() ) * brickWidthFromCenter
	#n = combinedV
	#print("new is now ", n)
	##if n.x > n.y:
		###print("flipping layer point x")
		##n.x = cos(((layerCenterPointVector.angle() + 90)) * brickWidthFromCenter) 
		##n.y = sin((layerCenterPointVector.angle() + 90)) * brickWidthFromCenter
		##print("adding angle to x ", n)
		###n.x = -n.x
	##else:
		##if n.y > n.x:
			###print("flipping layer point y")
			##n.x = cos(layerCenterPointVector.angle() + 0.25) * -brickWidthFromCenter
			##n.y = sin(layerCenterPointVector.angle() + 3) * -brickWidthFromCenter
			##print("adding angle to y ", n)
			###n.y = -n.y
	##print("returning next position ", n)
	#print("=======")
	#return n




func log(string: String):
	print("======")
	print(string)
	print("======")

func setVectorLength(v: Vector2, amount: float):
	if amount == 0:
		return v
	var length = v.length()
	var desiredLength = amount 
	return (desiredLength / length) * v


func getLayerAngle():
	var angle = (currentTower * 30) % 360
	return angle


func getCenterOfTowerOnCircle():
	var centerOfLayerOnCircle = Vector2()
	#for t in currentTower:
		#centerOfLayerOnCircle.x = cos(radius)
		#centerOfLayerOnCircle.y = -sin(radius)
		#currentTowerAngle = centerOfLayerOnCircle
	var angle = getLayerAngle()
	centerOfLayerOnCircle.x = cos(deg_to_rad(angle)) * radius
	centerOfLayerOnCircle.y = sin(deg_to_rad(angle)) * radius
	#print("getCenterOfLayerOnCircle: ", centerOfLayerOnCircle)
	return centerOfLayerOnCircle







func incrementTowerCount():
	currentTowerLayerHeight = 0
	currentTower += 1
	currentScale *= scaleFactor









