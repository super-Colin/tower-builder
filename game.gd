extends Node2D

var brickCost = Configs.brickCost
var moneyGenerationTime = Configs.moneyGenerationTime
var moneyGenerationTimer = moneyGenerationTime
var moneyGenerationAmount = Configs.moneyGenerationAmount



func _ready():
	Events.askToAddBrick.connect(_askToAddBrick)


func _process(delta):
	# camera
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$Camera2D.position.x += direction * 10
	else:
		$Camera2D.position.x += direction * -10
	direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		$Camera2D.position.y += direction * 10
	else:
		$Camera2D.position.y += direction * -10
	moneyGenerationTimer -= delta
	if moneyGenerationTimer < 0:
		generateMoney()
		moneyGenerationTimer = moneyGenerationTime



func generateMoney():
	Events.addMoney.emit(moneyGenerationAmount)


func _askToAddBrick():
	if not Globals.money >= brickCost:
		return
	else :
		Events.removeMoney.emit(brickCost)
		Events.addBrick.emit()
