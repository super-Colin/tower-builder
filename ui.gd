extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.moneyUpdated.connect(_updateMoneyDisplay)
	Events.stoneUpdated.connect(_updateStoneDisplay)
	$MarginContainer/HFlowContainer/AddBrick.button_up.connect(askToAddBrick)
	#print("ui ready")


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




