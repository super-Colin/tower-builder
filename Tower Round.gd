extends Node2D
var widthInBricksPerLayer = 4
var heightInBricksPerTower = 3

var currentTowerWidthInBricks = 0
var currentTowerLayerHeight = 0
var currentTower = 0
var currentTowerAngle = 0



var progressMap={
	"1":{
		"widthInBricksPerLayer":5,
		"heightInBricksPerLayer":8,
		"scaleFactor":8,
	}
}






#@export var radius = 1900
@export var radius = 200
@export var scaleFactor = 1.5

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


	var heightToAddFromLayers = (brickPixelHeight * currentScale.y * currentTowerLayerHeight) + towerCenterPointOnCircle.length()
	var towerCenterPointOnLayer = setVectorLength(towerCenterPointOnCircle, heightToAddFromLayers)
	newBrick.scale = currentScale
	newBrick.rotation = deg_to_rad(layerAngle + brickStartingAngle)
	newBrick.position = findBrickPointInLayer(towerCenterPointOnLayer)

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
	# if it's the middle of an odd row then return the center position
	if isCenterOfOddLayer:
		return layerCenterPointVector
	# build a new vector position.
	var bricksFromCenter = abs(midBrickPosition - (currentTowerWidthInBricks + 1))
	var brickWidthFromCenter = bricksFromCenter * currentBrickPixelWidthScaled()
	var offsetVector
	# if less than the middle block
	if currentTowerWidthInBricks +1 < midBrickPosition and widthInBricksPerLayer % 2 != 0:
		#print("<- left side of odd")
		offsetVector = setVectorLength(layerCenterPointVector.orthogonal(), brickWidthFromCenter)
	# if less than the middle block
	if currentTowerWidthInBricks +1 < midBrickPosition and widthInBricksPerLayer % 2 == 0:
		#print("<- left side of even")
		offsetVector = setVectorLength(layerCenterPointVector.orthogonal(), brickWidthFromCenter + (currentBrickPixelWidthScaled()/2))
	# if more than the middle block on an odd tower
	if currentTowerWidthInBricks +1 > midBrickPosition and widthInBricksPerLayer % 2 != 0:
		#print("-> right side of odd")
		offsetVector = setVectorLength(layerCenterPointVector.orthogonal() * -1, brickWidthFromCenter)
	# If more than the middle (an even number) and the total width is even
	if currentTowerWidthInBricks +1 > midBrickPosition and widthInBricksPerLayer % 2 == 0:
		#print("-> right side of even")
		offsetVector = setVectorLength(layerCenterPointVector.orthogonal() * -1, brickWidthFromCenter - (currentBrickPixelWidthScaled()/2))
	# If this is an even width tower
	if currentTowerWidthInBricks +1 == midBrickPosition :
		#print("-- center of even")
		offsetVector = setVectorLength(layerCenterPointVector.orthogonal(), currentBrickPixelWidthScaled()/2)
	#print("offsetVector is ", offsetVector)
	#print("=======")
	return layerCenterPointVector + offsetVector







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
	# adding a "- 90" to make the origin 12 o'clock instead of 3 o'clock
	var angle = ((currentTower * 30) - 90) % 360
	return angle

func currentBrickPixelWidthScaled():
	return brickPixelWidth * currentScale.x


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









