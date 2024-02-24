extends Node2D

var brickCost_money = Configs.brickCost_money
var brickCost_stone = Configs.brickCost_stone
var moneyGenerationTime = Configs.moneyGenerationTime
var moneyGenerationTimer = moneyGenerationTime
var moneyGenerationAmount = Configs.moneyGenerationAmount



func _ready():
	Events.askToAddBrick.connect(_askToAddBrick)


func _process(delta):
	generateMoney(delta)






func generateMoney(delta):
	moneyGenerationTimer -= delta
	if moneyGenerationTimer <= 0:
		moneyGenerationTimer = moneyGenerationTime
		Events.addMoney.emit(moneyGenerationAmount)
		Events.addBrick.emit()
		Events.addEarthEaten.emit(0.01)


func _askToAddBrick():
	if Globals.money >= brickCost_money and Globals.stone >= brickCost_stone:
		Events.removeMoney.emit(brickCost_money)
		Events.removeStone.emit(brickCost_stone)
		Events.addBrick.emit()
	else :
		return






#
#
#
#func _unhandled_input(event):
	#if event.is_action_pressed("scroll_up"):
		#print("zooming in")
		##_set_zoom_level(_zoom_level - zoom_factor)
	#if event.is_action_pressed("scroll_down"):
		#print("zooming out")
		##_set_zoom_level(_zoom_level + zoom_factor)
	##tween.tween_property($'.', "position", Vector2(0, 0), 1)
#






