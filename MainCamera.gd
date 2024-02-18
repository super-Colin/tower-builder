extends Camera2D

var followTower = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.towerHeightUpdated.connect(centerOnTower)
	Events.toggleCameraFollowTower.connect(_toggleFollowTower)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$'.'.position.x += direction * 10
	else:
		$'.'.position.x += direction * -10
	direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		$'.'.position.y += direction * 10
	else:
		$'.'.position.y += direction * -10



func centerOnTower():
	if followTower:
		$'.'.position.y = $"../Tower".brickHeight * (Globals.totalHeight - 5) * -1
	pass

func _toggleFollowTower():
	print("toggle follow tower")
	followTower = not followTower




