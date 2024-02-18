extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.moneyUpdated.connect(_updateMoneyDisplay)
	Events.stoneUpdated.connect(_updateStoneDisplay)
	Events.towerHeightUpdated.connect(_updateHeightDisplay)
	$MarginContainer/HFlowContainer/AddBrick.button_up.connect(askToAddBrick)
	#print("ui ready")
	$MarginContainer/HFlowContainer/CheckBox.toggled.connect(_toggleFollowTower)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func askToAddBrick():
	Events.askToAddBrick.emit()


func _updateMoneyDisplay():
	#print("updating money from ui")
	$MarginContainer/HFlowContainer/Money.text = "Money: %d" % Globals.money


func _updateStoneDisplay():
	#print("updating money from ui")
	$MarginContainer/HFlowContainer/Stone.text = "Stone: %d" % Globals.stone


func _updateHeightDisplay():
	#print("updating money from ui")
	$MarginContainer/HFlowContainer/Height.text = "Height: %d" % Globals.totalHeight

func _toggleFollowTower(toggled):
	Events.toggleCameraFollowTower.emit()



